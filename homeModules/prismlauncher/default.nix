{pkgs, ...}: let
  prism = pkgs.prismlauncher.override {
    additionalLibs = [
      pkgs.fontconfig
      pkgs.libxkbcommon
    ];
    jdks = with pkgs; [
      temurin-bin-25
      temurin-bin-21
      temurin-bin-17
      temurin-bin-8
    ];
  };
in {
  home.packages = [prism];
}
