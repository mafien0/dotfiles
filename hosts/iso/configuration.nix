{
  # pkgs,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../../nixosModules/nix
  ];
  nixpkgs.hostPlatform = "x86_64-linux";
  nixSettings.extraOptions = false;

  environment.interactiveShellInit = ''
    disko() {
      sudo nix --experimental-features "nix-command flakes" \
        run github:nix-community/disko/latest -- \
        --mode destroy,format,mount "$@"
    }
  '';
}
