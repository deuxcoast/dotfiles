return {
	"sudormrfbin/cheatsheet.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
	},
	bundled_plugin_cheatsheets = {
		-- show cheatsheets for all plugins except gitsigns
		disabled = { "nerd-fonts" },
	},

	-- ""
}
