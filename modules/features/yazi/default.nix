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
