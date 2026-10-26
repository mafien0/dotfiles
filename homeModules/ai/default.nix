# MADE BY CLANKER
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
      llmAgents.omp
      pkgs.mcp-nixos

      pkgs.ripgrep
      pkgs.fd
      pkgs.python3
    ];

    file = {
      ".omp/agent/AGENTS.md".text =
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

      # Read-only settings layer, loaded above ~/.omp/agent/config.yml.
      ".omp/agent/nix-settings.yml".source = ./nix-settings.yml;
    };

    sessionVariables.PI_CONFIG_FILES = "${config.home.homeDirectory}/.omp/agent/nix-settings.yml";
  };

  herdr.ompIntegration.enable = true;
}
