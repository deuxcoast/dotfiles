local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

return {
	--------------------------------------------------------------------------------------------------
	-- -LspConfig
	--------------------------------------------------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"b0o/schemastore.nvim",
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			"stevearc/conform.nvim",
			"folke/lazydev.nvim",
		},
		config = function()
			require("deux.config.lsp").setup()
		end,
	},

	--------------------------------------------------------------------------------------------------
	-- Conform
	--------------------------------------------------------------------------------------------------
	{
		"stevearc/conform.nvim",
		event = "BufEnter",
		cmd = { "ConformInfo" },
		config = function()
			require("deux.config.conform").setup()
		end,
	},

	----------------------------------------------------------------------------------------------------
	-- LazyDev
	----------------------------------------------------------------------------------------------------
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				"luvit-meta/library",
			},
		},
	},

	{
		"Bilal2453/luvit-meta",
		lazy = true,
	},

	{ -- optional completion source for require statements and module annotations
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
	},

	----------------------------------------------------------------------------------------------------
	-- Mason
	----------------------------------------------------------------------------------------------------

	{
		"williamboman/mason.nvim",
		event = "User FilePost",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonInstallAll",
			"MasonUpdate",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
	},

	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

	--------------------------------------
	--     {
	--       "hsaker312/diagnostics-details.nvim",
	--       cmd = "DiagnosticsDetailsOpenFloat",
	--       config = function()
	--         require("diagnostics-details").setup({
	--           -- Your configuration here
	--         })
	--       end,
	--     },
	-- {
	--   "aznhe21/actions-preview.nvim",
	--   dependencies = {
	--     "nvim-telescope/telescope.nvim",
	--   },
	-- },
}
