# MADE BY AI
{
  pkgs,
  lib,
  ...
}: let
  opencode2 = pkgs.llm-agents.opencode2;

  cavemanPrompt = builtins.readFile ./caveman.md;
in {
  home = {
    packages = [
      opencode2
      pkgs.mcp-nixos
      pkgs.llm-agents.dsh
    ];

    shellAliases.op = lib.getExe opencode2;

    file = {
      ".config/opencode/AGENTS.md".text =
        "${cavemanPrompt}\n\n"
        + ''
          - Prefer `rg` over `grep`, `fd` over `find`.
          - Never commit without being asked.
          - Never edit without permission; if asked question, answer it, not implement it
          - Keep diffs minimal; no drive-by refactors.
          - Dont write useless comments, code should be self-explaining
        '';

      ".config/opencode/cli.json".text = builtins.toJSON {
        "$schema" = "https://opencode.ai/v2/cli.json";
        tabs.enabled = false;
        theme.name = "system";
      };
    };
  };
}
