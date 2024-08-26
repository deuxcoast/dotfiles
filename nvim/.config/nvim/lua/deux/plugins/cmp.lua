local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

return {
	{
		"hrsh7th/nvim-cmp",
		cond = has_ui,
		lazy = false,
		priority = 100,
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",

			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require "deux.config.cmp"
		end,
	}, {
	"L3MON4D3/LuaSnip",
	cond = has_ui,
	build = "make install_jsregexp",
	version = "v2.*",
	config = function()
		require("deux.config.luasnip").setup()
	end
}
}
