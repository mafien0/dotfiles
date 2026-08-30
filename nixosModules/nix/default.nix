{
  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;
  };
  nix.settings = {
    trusted-users = ["@wheel"];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    max-jobs = 4;
    cores = 0;
    warn-dirty = false;
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://vic.cachix.org"
      "https://spicetify-nix.cachix.org"
      "https://helium-nix.cachix.org"
      "https://noctalia.cachix.org"
      "https://niri-epireyn.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "vic.cachix.org-1:1fQNG1DxLTGd47MBAtr/IrUYIk+TTXDojOItpqFoxII="
      "spicetify-nix.cachix.org-1:jjnwULkvMdu0E5KGBbtgrISEfDdJTGSZ4ATkiFzZn5I="
      "helium-nix.cachix.org-1:a8YPjt9O4GPyX0u3gjg/aWpb14teU9aRiSG/MOaSFgw="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA="
    ];
  };
  nix.extraOptions = ''
    !include /home/mafien0/.config/nix/access-tokens.conf
  '';
}
