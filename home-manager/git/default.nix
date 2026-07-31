let
  user = {
    name = "mafien0";
    email = "mafien_0@tuta.io";
  };
in {
  programs.git = {
    enable = true;
    signing = {
      key = "~/.ssh/id_ed25519.pub";
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
    };
  };
}
