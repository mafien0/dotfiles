# MADE BY AI
{
  pkgs,
  config,
  inputs,
  system,
  ...
}: let
  llmAgents = inputs.llm-agents.packages.${system};
in {
  imports = [./theme.nix];

  home = {
    packages = [
      llmAgents.omp # No config, omp is yucky
      pkgs.mcp-nixos

      pkgs.ripgrep
      pkgs.fd
    ];

    file = {
      ".omp/agent/AGENTS.md".text =
        ''
          - Prefer `rg` over `grep`, `fd` over `find`.
          - Never commit without being asked.
          - Never edit without permission; if asked question, answer it, not implement it
          - Keep diffs minimal; no drive-by refactors.
          - Dont write useless comments, code should be self-explaining
        ''
        + "${builtins.readFile ./caveman.md}\n\n"
        + "${builtins.readFile ./judge.md}\n\n";

      # Read-only settings layer, loaded above ~/.omp/agent/config.yml.
      ".omp/agent/nix-settings.yml".source = ./nix-settings.yml;
    };

    sessionVariables.PI_CONFIG_FILES = "${config.home.homeDirectory}/.omp/agent/nix-settings.yml";
  };
}
