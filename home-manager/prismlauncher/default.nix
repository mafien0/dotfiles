{
	pkgs,
	lib,
	...
}: let
	prism =
		pkgs.prismlauncher.override {
			additionalPrograms = [
				pkgs.fontconfig
			];
			jdks = with pkgs; [
				temurin-bin-25
				temurin-bin-21
				temurin-bin-17
				temurin-bin-8
			];
		};
in {
	home.packages = [
		(prism.overrideAttrs (old: {
					qtWrapperArgs =
						(old.qtWrapperArgs or [])
						++ [
							"--prefix"
							"LD_LIBRARY_PATH"
							":"
							(lib.makeLibraryPath [
									pkgs.fontconfig
								])
						];
				}))
	];
}
