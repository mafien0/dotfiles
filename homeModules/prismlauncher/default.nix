{pkgs, ...}: let
  prism = pkgs.prismlauncher.override {
    additionalLibs = with pkgs; [
      zenity
      fontconfig
      sdl3.lib
      libxkbcommon # https://github.com/NixOS/nixpkgs/pull/572251
      libxi # https://github.com/NixOS/nixpkgs/pull/571087
    ];
    jdks = with pkgs; [
      temurin-bin-25
      temurin-bin-21
      temurin-bin-17
      temurin-bin-8
    ];
  };
in {
  home.packages = [
    prism
    pkgs.zenity
  ];
}
