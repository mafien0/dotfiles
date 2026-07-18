{
	autocomplete = {
		blink-cmp = {
			enable = true;
			setupOpts = {
				keymap = {
					preset = "super-tab";
				};
				appearance = {
					nerd_font_variant = "mono";
				};
				completion = {
					documentation = {
						auto_show = false;
					};
				};
				sources = {
					default = [
						"lsp"
						"path"
						"snippets"
						"buffer"
					];
				};
				fuzzy = {
					implementation = "prefer_rust_with_warning";
				};
			};
			friendly-snippets = {
				enable = true;
			};
		};
	};

	snippets = {
		luasnip = {
			enable = true;
		};
	};

	luaConfigRC.cmp_snippets = ''
		require("luasnip.loaders.from_vscode").load({
		  paths = vim.fn.stdpath("config") .. "/snippets",
		})
	'';
}
