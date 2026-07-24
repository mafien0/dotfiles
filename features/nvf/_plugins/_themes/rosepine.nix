{pkgs}: {
	extraPlugins.rose-pine = {
		package = pkgs.vimPlugins.rose-pine;
		setup = "require('rose-pine').setup {}";
	};

	luaConfigRC.rose_pine = ''
		if vim.g.colors_name == nil or vim.g.colors_name == "" then
		  local ok = pcall(vim.cmd.colorscheme, "rose-pine")
		  if not ok then
		    vim.cmd.colorscheme("default")
		  end
		end
	'';
}
