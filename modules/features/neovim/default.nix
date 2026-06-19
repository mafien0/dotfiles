{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.neovim = moduleWithSystem (
    { config, ... }: { pkgs, lib, ... }: {
      environment.systemPackages = [ config.packages.myNeovim ];
      environment.sessionVariables.EDITOR = "nvim";
    }
  );

  perSystem = { pkgs, ... }: {
    packages.myNeovim = inputs.wrapper-modules.wrappers.neovim.wrap {
      inherit pkgs;

      settings = {
        config_directory = ./nvim;
        block_normal_config = false;
        aliases = [
          "vim"
          "v"
        ];
      };

      runtimePkgs = with pkgs; [
        ripgrep
        fd
        matugen
      ];
    };
  };
}
