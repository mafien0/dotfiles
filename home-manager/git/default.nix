let
  user = {
    name = "mafien0";
    email = "mafien_0@tuta.io";
  };
  signingKey = "~/.ssh/id_ed25519.pub";
in {
  programs.git = {
    enable = true;
    signing = {
      key = signingKey;
      signByDefault = true;
    };
    settings = {
      inherit user;
      init.defaultBranch = "main";
      tag.gpgSign = true;
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
    };
  };
  programs.jujutsu = {
    enable = true;
    settings = {
      inherit user;

      signing = {
        backend = "ssh";
        key = signingKey;
        sign-all = true;
      };
    };
  };
}
