local package = DV.pack.package
local conf = require("modules.ui.config")

--------------------------------------------------------------------------------
-- Alpha.nvim
--------------------------------------------------------------------------------
package({
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = conf.alpha,
})

--------------------------------------------------------------------------------
-- LuaLine
--------------------------------------------------------------------------------
package({
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			-- set an empty statusline till lualine loads
			vim.o.statusline = " "
		else
			-- hide the statusline on the starter page
			vim.o.laststatus = 0
		end
	end,
	config = conf.lualine,
})

--------------------------------------------------------------------------------
-- Which-Key
--------------------------------------------------------------------------------
package({
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		require("which-key").setup({
			timeoutlen = 500,
			delay = 500,
			win = {
				border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
			},
		})
	end,
})
