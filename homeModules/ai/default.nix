# MADE BY AI
{
  pkgs,
  inputs,
  system,
  ...
}: let
  llmAgents = inputs.llm-agents.packages.${system};
  ompConfig = (pkgs.formats.yaml {}).generate "omp-config.yml" {
    modelRoles.default = "deepseek/deepseek-v4-flash";
    symbolPreset = "nerd";
    composer.shape = "band";
    theme = {
      dark = "dark-gruvbox";
      light = "light";
    };
    setupVersion = 2;
    colorBlindMode = false;
  };
in {
  home = {
    packages = [
      llmAgents.omp
      pkgs.mcp-nixos

      pkgs.ripgrep
      pkgs.fd
    ];

    file = {
      ".omp/agent/AGENTS.md".text =
        "${builtins.readFile ./caveman.md}\n\n"
        + ''
          - Prefer `rg` over `grep`, `fd` over `find`.
          - Never commit without being asked.
          - Never edit without permission; if asked question, answer it, not implement it
          - Keep diffs minimal; no drive-by refactors.
          - Dont write useless comments, code should be self-explaining
        '';

      ".omp/agent/config.yml".source = ompConfig;
    };
  };
}
