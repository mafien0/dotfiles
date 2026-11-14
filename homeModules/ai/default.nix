# MADE BY CLANKER
{
  pkgs,
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


          - You have python3 at your disposal, use it to write simple scripts, check some stuff, etc
          - You have THE POWER OF NIX at your disposal
          - You can run any software you need, but only from nixpkgs
          - Pulling packages from other flakes is forbidden
          - Ask for permission before running huge packages
          - Always use flakes (e.g. `nix run nixpkgs#cowsay`)

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
