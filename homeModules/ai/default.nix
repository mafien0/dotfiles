# MADE BY AI
{
  pkgs,
  lib,
  inputs,
  system,
  ...
}: let
  llmAgents = inputs.llm-agents.packages.${system};
in {
  home = {
    packages = [
      llmAgents.opencode2
      pkgs.mcp-nixos
      llmAgents.dsh

      pkgs.ripgrep
      pkgs.fd
    ];

    shellAliases.op = lib.getExe llmAgents.opencode2;

    file = {
      ".config/opencode/AGENTS.md".text =
        "${builtins.readFile ./caveman.md}\n\n"
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
