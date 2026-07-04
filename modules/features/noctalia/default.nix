{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;

      outOfStoreConfig = "/home/mafien0/.config/noctalia";

      inherit ((builtins.fromJSON (builtins.readFile ./noctalia.json))) settings;

      runtimePkgs = with pkgs; [
        cliphist
        wl-clipboard
      ];

      user-templates = {
        neovim = {
          input_path = "~/nix/modules/features/neovim/nvim/lua/matugen-template.lua";
          output_path = "~/nix/modules/features/neovim/nvim/lua/matugen.lua";
          post_hook = "pkill -SIGUSR1 nvim";
        };
      };
    };
  };
}
