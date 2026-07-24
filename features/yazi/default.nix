{
	inputs,
	moduleWithSystem,
	...
}: {
	flake.nixosModules.yazi =
		moduleWithSystem (
			{config, ...}: _: {
				environment.systemPackages = [config.packages.myYazi];
			}
		);

	perSystem = {pkgs, ...}: {
		packages.myYazi =
			inputs.wrapper-modules.wrappers.yazi.wrap {
				inherit pkgs;

				aliases = ["y"];

				settings = {
					yazi = {
						manager = {
							show_hidden = true;
							show_symlink = false;
							sort_by = "natural";
							sort_dir_first = true;
							linemode = "none";
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
					fzf
					zoxide
				];
			};
	};
}
