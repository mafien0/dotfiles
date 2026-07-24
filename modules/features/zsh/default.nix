{
	inputs,
	moduleWithSystem,
	...
}: {
	flake.nixosModules.zsh =
		moduleWithSystem (
			_: {
				pkgs,
				lib,
				...
			}: {
				programs.zsh = {
					enable = true;
					syntaxHighlighting.enable = true;
					autosuggestions.enable = true;
					histSize = 10000;
					histFile = "~/.zsh_history";

					shellAliases = {
						l = "${lib.getExe pkgs.eza} -la --icons=auto --classify --group-directories-first --header --time-style=long-iso";
						ls = "${lib.getExe pkgs.eza} --icons=auto --classify --group-directories-first --header --time-style=long-iso";
						lt = "${lib.getExe pkgs.eza} --tree --icons=auto --classify --group-directories-first --header --time-style=long-iso";
						g = "${lib.getExe pkgs.git}";
						c = "clear";
					};

					setOptions = [
						"appendhistory"
						"incappendhistory"
						"sharehistory"
					];

					ohMyZsh = {
						enable = true;
						theme = "candy";
					};

					interactiveShellInit = ''
												fpath=(~/.zsh $fpath)

												autoload -U up-line-or-beginning-search down-line-or-beginning-search
												zle -N up-line-or-beginning-search
												zle -N down-line-or-beginning-search
												bindkey "^[[A" up-line-or-beginning-search
												bindkey "^[[B" down-line-or-beginning-search

												unsetopt PROMPT_SP

												function precmd {
												    print -Pn "\e[ q"
												}

												if [[ ! -f ~/tokens.sh ]]; then
																		  echo '#!/usr/bin/sh' > ~/tokens.sh
																		  echo 'echo "change ~/tokens.sh"' >> ~/tokens.sh
																		  echo 'export GITHUB_TOKEN="changeme"' >> ~/tokens.sh
																		  chmod +x ~/tokens.sh
																		fi
																		[[ -f ~/tokens.sh ]] && source ~/tokens.sh
																		if [[ -n "$GITHUB_TOKEN" ]]; then
						  mkdir -p ~/.config/nix
						  echo "access-tokens = github.com=$GITHUB_TOKEN" > ~/.config/nix/access-tokens.conf
						fi
					'';
				};
			}
		);

	perSystem = {pkgs, ...}: {
		packages.myZsh =
			inputs.wrapper-modules.wrappers.zsh.wrap {
				inherit pkgs;
				runtimePkgs = [pkgs.git];
				zshrc.content = "# i use nixos btw";
			};
	};
}
