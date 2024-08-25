return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neogit").setup({})

		local map = require("deux.utils.keymap")
		local cmd = map.cmd
		map.n("<leader>ng", cmd("Neogit"))
	end
}
