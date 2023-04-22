local colors = {
	black = "#161616",
	white = "#dde1e6",
	blue = "#33b1ff",
	green = "#42be65",
	magenta = "#ff7eb6",
	yellow = "#ffe97b",
	cyan = "#3ddbd9",
	red = "#ff5189",
}
return {
	"akinsho/bufferline.nvim",
	event = "VimEnter",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	init = function()
		vim.keymap.set("n", "<TAB>", ":BufferLineCycleNext<CR>")
		vim.keymap.set("n", "<S-TAB>", ":BufferLineCyclePrev<CR>")
	end,
	config = function()
		require("bufferline").setup({
			highlights = {
				fill = {
					bg = colors.black,
				},
				background = {
					fg = colors.white,
					bg = colors.black,
				},
				buffer_selected = {
					fg = colors.green,
					bg = colors.black,
				},
				indicator_selected = {
					fg = colors.green,
					bg = colors.black,
				},
				close_button_selected = {
					bg = colors.black,
					fg = colors.green,
				},
			},
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						highlight = "Directory",
					},
				},
			},
		})
	end,
}
