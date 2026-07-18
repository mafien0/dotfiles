{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.git = moduleWithSystem (
    {config, ...}: _: {
      environment.systemPackages = [config.packages.myGit];
    }
  );

  perSystem = {pkgs, ...}: {
    packages.myGit = inputs.wrapper-modules.wrappers.git.wrap {
      inherit pkgs;
      aliases = ["g"];
      settings = {
        user = {
          name = "mafien0";
          email = "mafien_0@tuta.io";
          signingkey = "/home/mafien0/.ssh/id_ed25519.pub";
        };
        init = {
          defaultBranch = "main";
        };
        commit = {
          gpgsign = true;
        };
        tag = {
          gpgsign = true;
        };
        gpg = {
          format = "ssh";
          ssh = {
            allowedSignersFile = "/home/mafien0/.ssh/allowed_signers";
          };
        };
      };
    };
  };
}
