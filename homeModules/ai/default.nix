# MADE BY AI
{pkgs, ...}: {
  home.packages = [
    pkgs.pi-coding-agent
    pkgs.mcp-nixos
    pkgs.llm-agents.dsh
  ];

  home.file.".pi/agent/APPEND_SYSTEM.md".text = ''
    - Prefer `rg` over `grep`, `fd` over `find`.
    - Never commit without being asked.
    - Never edit without permission; if asked question, answer it, not implement it
    - Keep diffs minimal; no drive-by refactors.
    - Dont write useless comments; code should be self-explaining
  '';
}
