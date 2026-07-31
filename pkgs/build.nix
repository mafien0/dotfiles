{
  pkgs,
  lib,
  flakePath,
}:
pkgs.writers.writePython3Bin "build" {}
/*
python
*/
''
  from argparse import ArgumentParser
  import subprocess
  import sys

  RESET = "\033[0m"
  RED = "\033[31m"
  GREEN = "\033[32m"
  CYAN = "\033[36m"

  nix_bin = "${lib.getExe pkgs.nix}"
  nh_bin = "${lib.getExe pkgs.nh}"

  parser = ArgumentParser(
      add_help=False, description="default"
  )
  parser.add_argument("path", nargs="?", default=None)
  parser.add_argument("-b", "--boot", action="store_true")
  parser.add_argument("-f", "--flake", action="store_true")
  parser.add_argument("-h", "--home", action="store_true")
  parser.add_argument("-o", "--os", action="store_true")

  args = parser.parse_args()


  def run(args: list[str], name: str):
      print(f"Running {name}")
      print("-" * 50)

      try:
          result = subprocess.run(args, text=True)
      except KeyboardInterrupt:
          print("\ninterrupted by the user")
          sys.exit(1)

      if result.returncode != 0:
          raise RuntimeError(f"{name} failed!")
      print(f"{CYAN}--- {name} finished ---{RESET}\n")


  if __name__ == "__main__":
      if len(sys.argv) == 1:
          print(f"{RED}No arguments were provided.{RESET}")
          sys.exit(1)

      user_flake = args.path or r"${flakePath}"

      if args.os:
          print(f"{RED}Building os requires sudo{RESET}")
          try:
              subprocess.run(["sudo", "-v"], check=True)
          except KeyboardInterrupt:
              print("\ninterrupted by the user")
              sys.exit(1)

      operation = "switch"
      if args.boot:
          operation = "boot"

      if args.flake:
          run([nix_bin, "flake", "update", "--flake", user_flake],
              "flake inputs update")

      if args.os:
          run([nh_bin, "os", operation, user_flake],
              "os rebuild")

      if args.home:
          run([nh_bin, "home", operation, user_flake],
              "home rebuild")

      print(f"{GREEN}Succesfully built!{RESET}")
''
