local package = require("util").pack.package
local conf = require("modules.completion.config")

package({
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"saadparwaiz1/cmp_luasnip",

		-- "mireq/luasnip-snippets",
		"onsails/lspkind.nvim",
		"abecodes/tabout.nvim",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			-- event = "VeryLazy",
			config = conf.luasnip,
			build = "make install_jsregexp",
		},
	},
	config = conf.completion,
})
