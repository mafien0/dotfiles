# MADE BY CLANKER
{
  pkgs,
  lib,
  inputs,
  system,
  config,
  ...
}: let
  llmAgents = inputs.llm-agents.packages.${system};
in {
  home = {
    sessionPath = ["${config.home.homeDirectory}/.local/bin"];

    packages = [
      llmAgents.opencode2
      pkgs.mcp-nixos

      pkgs.ripgrep
      pkgs.fd
      pkgs.python3
      pkgs.nushell
    ];

    file = {
      ".config/opencode/AGENTS.md".text =
        ''
          - Prefer `rg` over `grep`, `fd` over `find`.
          - Use git read-only actions when needed.
          - Never use git write actions without permission(eg. commits, pushes).
          - Never edit without permission; if asked a question, answer it, don't implement it.
          - Keep diffs minimal; no drive-by refactors.
          - Don't write useless comments. Code should be self-explanatory.

          - Browser MCP workflow: call `browse.status` first; if paired-offline/reconnecting, wait via shell `sleep` then retry (no `setTimeout` in execute). `browse.navigate({ url })` with no tab opens a tab and returns its `tab` id; reuse it. `browse.snapshot({ tab })` before acting; refs like `e12` go stale after changes, resnapshot. Act with `browse.click/fill/type/select/hover/drag` using `ref`+`tab`; verify with fresh snapshot/screenshot. Close tabs you opened when done.
          - To use browser mcp you dont need to find the exact browser{, path}. just try invoking it


          - Prefer nushell over anything. Use nushell when needed to write simple scripts, invoke http request, etc. to use it run `nu -c <command>`
          - Do not suggest nushell code to me. if you really want to show some code: write python
          - Never use curl. if you need to make an http request use nushell.
          - You have python3 at your disposal, use it to write scripts that nushell can't do
          - You have THE POWER OF NIX at your disposal
          - You can run any software you need, but only from nixpkgs
          - Pulling packages from other flakes is forbidden
          - Ask for permission before running huge packages
          - Always use flakes: `nix shell nixpkgs#pkg`, `nix run nixpkgs#pkg`, `nix shell nixpkgs#{pkg1,pkg2}`; never `nix-shell`/`nix-env`.
          - When doing nix-stuff, rely on mcp first, search the web or run commands only if mcp can't do what you want
          - I'm totally fine with cloning git repos with `--depth=1` into `/tmp` as long as no code will be executed. Use it for your greps and finds

          - Never speak chinese, if you forgot what langauge to speak in, default to english.
        ''
        + "${builtins.readFile ./caveman.md}\n\n"
        + "${builtins.readFile ./judge.md}\n\n";

      ".config/opencode/opencode.json".text = builtins.toJSON {
        "$schema" = "https://opencode.ai/config.json";
        update = "disable";
        mcp = {
          servers = {
            browse = {
              type = "local";
              command = [
                "${config.home.homeDirectory}/.local/bin/browse"
                "mcp"
              ];
              environment = {
                OPENCODE_BROWSER_RUNTIME = "auto-update";
              };
            };
            nixos = {
              type = "local";
              command = [
                (lib.getExe pkgs.mcp-nixos)
              ];
            };
          };
        };
      };

      ".config/opencode/cli.json".text = builtins.toJSON {
        "$schema" = "https://opencode.ai/v2/cli.json";
        theme = {
          name = "system";
          mode = "system";
        };
        tabs = {
          mode = "off";
        };
      };
    };
  };
}
