# MADE BY CLANKER
{pkgs}:
pkgs.writers.writePython3Bin "obsreplay" {
  libraries = [
    pkgs.python3Packages.websocket-client
  ];
  flakeIgnore = ["E501"];
}
# python
''
  import base64
  import hashlib
  import json
  import os
  import subprocess
  import sys
  import time
  import uuid

  import websocket


  WS_URL = "ws://localhost:4455"
  NOTIFY_SEND = "${pkgs.libnotify}/bin/notify-send"


  def notify(title, message):
      print(f"{title}: {message}")
      subprocess.run(
          [NOTIFY_SEND, title, message],
          check=False,
      )


  def die(message):
      notify("OBS Replay", message)
      sys.exit(1)


  def identify(ws, hello):
      data = hello["d"]

      identify_data = {
          "rpcVersion": 1,
      }

      authentication = data.get("authentication")

      if authentication:
          password = os.environ.get("OBS_WEBSOCKET_PASSWORD")

          if password is None:
              die(
                  "OBS requires a WebSocket password. "
                  "Set OBS_WEBSOCKET_PASSWORD."
              )

          secret = base64.b64encode(
              hashlib.sha256(
                  (password + authentication["salt"]).encode()
              ).digest()
          ).decode()

          auth = base64.b64encode(
              hashlib.sha256(
                  (secret + authentication["challenge"]).encode()
              ).digest()
          ).decode()

          identify_data["authentication"] = auth

      ws.send(
          json.dumps({
              "op": 1,
              "d": identify_data,
          })
      )

      response = json.loads(ws.recv())

      if response.get("op") != 2:
          die(f"OBS identification failed: {response}")


  def send_ws(ws, request_type, **params):
      request_id = str(uuid.uuid4())

      ws.send(
          json.dumps({
              "op": 6,
              "d": {
                  "requestType": request_type,
                  "requestId": request_id,
                  "requestData": params,
              },
          })
      )

      while True:
          raw = ws.recv()

          if not raw:
              die("WebSocket connection closed")

          message = json.loads(raw)

          if message.get("op") == 7 and (
              message.get("d", {}).get("requestId") == request_id
          ):
              data = message["d"]
              status = data["requestStatus"]

              if not status["result"]:
                  die(
                      f"{request_type} failed: "
                      f"{status.get('comment', 'unknown error')}"
                  )

              return data.get("responseData", {})


  def wait_for_event(ws, event_type):
      while True:
          raw = ws.recv()

          if not raw:
              die("WebSocket connection closed")

          message = json.loads(raw)

          if message.get("op") != 5:
              continue

          data = message["d"]

          if data.get("eventType") == event_type:
              return data.get("eventData", {})


  def main():
      try:
          ws = websocket.create_connection(WS_URL)
      except Exception as e:
          die(f"Failed to connect to OBS: {e}")

      try:
          # OBS WebSocket 5.x sends Hello first.
          hello = json.loads(ws.recv())

          if hello.get("op") != 0:
              die(f"Unexpected OBS message: {hello}")

          identify(ws, hello)

          # Make sure the replay buffer is running.
          status = send_ws(ws, "GetReplayBufferStatus")

          if not status.get("outputActive"):
              send_ws(ws, "StartReplayBuffer")

              # StartReplayBuffer is asynchronous.
              wait_for_event(ws, "ReplayBufferStarted")

          # Give the replay buffer something to capture.
          time.sleep(2)

          # Save the replay buffer.
          send_ws(ws, "SaveReplayBuffer")

          # OBS emits the actual saved path in this event.
          event = wait_for_event(ws, "ReplayBufferSaved")
          path = event.get("savedReplayPath", "unknown")

          notify(
              "OBS Replay",
              f"Saved replay to: {path}",
          )

      except websocket.WebSocketException as e:
          die(f"WebSocket error: {e}")

      finally:
          ws.close()


  if __name__ == "__main__":
      main()
''
