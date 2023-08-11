local colors = {
	background = "#080808",
	foreground = "#b2b2b2",
	cursor = "#9e9e9e",
	color0 = "#323437",
	color1 = "#ff5454",
	color2 = "#8cc85f",
	color3 = "#e3c78a",
	color4 = "#80a0ff",
	color5 = "#cf87e8",
	color6 = "#79dac8",
	color7 = "#c6c6c6",
	color8 = "#949494",
	color9 = "#ff5189",
	color10 = "#36c692",
	color11 = "#c2c292",
	color12 = "#74b2ff",
	color13 = "#ae81ff",
	color14 = "#85dc85",
	color15 = "#e4e4e4",
	selection_background = "#b2ceee",
	selection_foreground = "#080808",
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
				--[[ 	fill = { ]]
				--[[ 		bg = colors.black, ]]
				--[[ 	}, ]]
				--[[ 	background = { ]]
				--[[ 		fg = colors.white, ]]
				--[[ 		bg = colors.black, ]]
				--[[ 	}, ]]
				buffer_selected = {
					fg = colors.color14,
					bg = colors.background,
				},
				indicator_selected = {
					fg = colors.color14,
					bg = colors.background,
				},
				close_button_selected = {
					fg = colors.color14,
					bg = colors.background,
				},
				modified = {
					fg = colors.color13,
					bg = colors.background,
				},
				modified_selected = {
					fg = colors.color13,
					background = colors.background,
				},
			},
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
