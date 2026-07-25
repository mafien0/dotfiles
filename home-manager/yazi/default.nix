{pkgs, ...}: {
	home.packages = with pkgs; [
		yazi
		file
		poppler
		ffmpegthumbnailer
		p7zip
		zip
		unzip
		unar
		chafa
		fzf
		zoxide
	];

	home.shellAliases = {
		y = "yazi";
	};

	programs.yazi = {
		enable = true;
		settings = {
			manager = {
				show_hidden = true;
				show_symlink = false;
				sort_by = "natural";
				sort_dir_first = true;
				linemode = "none";
			};
		};
	};
}
