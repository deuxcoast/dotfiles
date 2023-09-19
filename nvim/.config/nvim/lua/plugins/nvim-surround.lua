return {
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			-- vim-sandwich keymaps
			keymaps = {
				normal = "sa",
				delete = "sd",
				change = "sr",
			},
		})
	end,
}
