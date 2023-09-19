return {
	"akinsho/bufferline.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		vim.keymap.set("n", "<TAB>", ":BufferLineCycleNext<CR>")
		vim.keymap.set("n", "<S-TAB>", ":BufferLineCyclePrev<CR>")
	end,
	config = function()
		require("bufferline").setup({
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						--[[ highlight = "Directory", ]]
					},
				},
			},
		})
	end,
}
