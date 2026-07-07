{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.opencode = moduleWithSystem (
    { config, ... }: _: {
      environment.systemPackages = [ config.packages.myOpencode ];
    }
  );

  perSystem = { pkgs, ... }: {
    packages.myOpencode = inputs.wrapper-modules.wrappers.opencode.wrap {
      inherit pkgs;
      settings = {
        theme = "system";
        lsp = true;
        mcp.nixos = {
          type = "local";
          command = [ "mcp-nixos" ];
          enabled = true;
        };
      };
      runtimePkgs = with pkgs; [ mcp-nixos ];
    };
  };
}
