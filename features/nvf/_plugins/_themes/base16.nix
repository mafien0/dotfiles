{pkgs}: {
	extraPlugins.base16-nvim = {
		package = pkgs.vimPlugins.base16-nvim;
	};

	luaConfigRC.base16_noctalia = ''
		local matugen_path = vim.api.nvim_get_runtime_file("lua/matugen.lua", false)[1]
		if matugen_path then
		  local matugen = dofile(matugen_path)
		  matugen.setup()
		  vim.g.colors_name = "base16-noctalia"

		  local signal = vim.uv.new_signal()
		  signal:start("sigusr1", vim.schedule_wrap(function()
		    package.loaded["base16-colorscheme"] = nil
		    local m = dofile(matugen_path)
		    m.setup()
		  end))
		end
	'';
}
