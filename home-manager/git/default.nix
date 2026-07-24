{
	programs.git = {
		enable = true;

		userName = "mafien0";
		userEmail = "mafien_0@tuta.io";

		signing = {
			key = "~/.ssh/id_ed25519.pub";
			signByDefault = true;
		};

		extraConfig = {
			init.defaultBranch = "main";

			tag.gpgSign = true;

			gpg = {
				format = "ssh";
				ssh.allowedSignersFile = "~/.ssh/allowed_signers";
			};
		};
	};
}
