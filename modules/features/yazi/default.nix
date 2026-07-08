{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.yazi = moduleWithSystem (
    { config, ... }: _: {
      environment.systemPackages = [ config.packages.myYazi ];
    }
  );

  perSystem =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      packages.myYazi = inputs.wrapper-modules.wrappers.yazi.wrap {
        inherit pkgs;

        aliases = [ "y" ];

        settings = {
          yazi = {
            manager = {
              show_hidden = false;
              show_symlink = true;
              sort_by = "natural";
              sort_dir_first = true;
              linemode = "none";
            };
            preview = {
              max_ratio = 0.6;
              min_ratio = 0.2;
              image_filter = "lanczos3";
              image_quality = 75;
            };
            opener = {
              edit = [
                {
                  run = ''${lib.getExe config.packages.myFeet} -e nvim "$@"'';
                  block = true;
                  orphan = false;
                  desc = "Edit with Neovim";
                }
              ];
            };
          };
          keymap = {
            manager = {
              prepend_keymap = [
                {
                  on = [ "s" ];
                  run = "shell '${pkgs.fzf}/bin/fzf | xargs -r nvim' --block --confirm";
                  desc = "Fuzzy find and open in nvim";
                }
                {
                  on = [ "S" ];
                  run = "shell '${pkgs.fzf}/bin/fzf' --block";
                  desc = "Fzf search";
                }
              ];
            };
          };
          theme = {
            manager = {
              border_style = {
                fg = "blue";
              };
              active_border_style = {
                fg = "green";
              };
            };
            status = {
              separator_open = "[";
              separator_close = "]";
              separator_style = {
                fg = "blue";
              };
            };
          };
        };

        runtimePkgs = with pkgs; [
          file
          poppler
          ffmpegthumbnailer
          p7zip
          zip
          unzip
          unar
          chafa
        ];
      };
    };
}
