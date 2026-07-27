{pkgs, ...}: {
	home.packages = with pkgs; [
		# Nix
		deadnix
		nixd
		alejandra
		nixpkgs-lint-community
		statix

		(writeShellApplication {
				name = "nixtest";

				runtimeInputs = [
					nixpkgs-lint-community
					alejandra
					statix
					deadnix
				];

				text = ''
					echo "--- nixpkgs-lint ---"
					nixpkgs-lint "$1"
					echo "end"

					echo "--- alejandra check ---"
					alejandra -c -q "$1"
					echo "end"

					echo "--- statix check ---"
					statix check "$1"
					echo "end"

					echo "--- deadnix check ---"
					deadnix "$1"
					echo "end"
				'';
			})

		(writeShellApplication {
				name = "nixformat";

				runtimeInputs = [
					alejandra
					statix
					deadnix
				];

				text = ''
					echo "--- alejandra format ---"
					alejandra -q "$1"
					echo "end"

					echo "--- statix fix ---"
					statix fix "$1"
					echo "end"

					echo "--- deadnix edit ---"
					deadnix -e "$1"
					echo "end"
				'';
			})
	];
}
