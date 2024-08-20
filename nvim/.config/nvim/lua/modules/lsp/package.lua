local package = DV.pack.package
local conf = require("modules.lsp.config")

----------------------------------------------------------------------------------------------------
-- -LspConfig
----------------------------------------------------------------------------------------------------
package({
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
	-- ft = _G.my_program_ft,
	config = conf.lsp,
})

----------------------------------------------------------------------------------------------------
-- Conform
----------------------------------------------------------------------------------------------------
package({
	"stevearc/conform.nvim",
	event = "BufEnter",
	cmd = { "ConformInfo" },
	config = conf.formatter,
})

----------------------------------------------------------------------------------------------------
-- LazyDev
----------------------------------------------------------------------------------------------------
package({
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	opts = {
		library = {
			"luvit-meta/library",
		},
	},
})

package({ "Bilal2453/luvit-meta", lazy = true })

package({ -- optional completion source for require statements and module annotations
	"hrsh7th/nvim-cmp",
	opts = function(_, opts)
		opts.sources = opts.sources or {}
		table.insert(opts.sources, {
			name = "lazydev",
			group_index = 0, -- set group index to 0 to skip loading LuaLS completions
		})
	end,
})

----------------------------------------------------------------------------------------------------
-- Mason
----------------------------------------------------------------------------------------------------

package({
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
})

package({ "WhoIsSethDaniel/mason-tool-installer.nvim" })
