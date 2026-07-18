{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;

      outOfStoreConfig = "/home/mafien0/.config/noctalia";

      inherit ((builtins.fromJSON (builtins.readFile ./noctalia.json))) settings;

      runtimePkgs = with pkgs; [
        cliphist
        wl-clipboard
      ];

      user-templates = {
        templates = {
          neovim = {
            input_path = "/home/mafien0/nix/modules/features/nvf/_templates/matugen.lua";
            output_path = "/home/mafien0/nix/modules/features/nvf/_generated/lua/matugen.lua";
            post_hook = "pkill -SIGUSR1 nvim";
          };
        };
      };
    };
  };
}
