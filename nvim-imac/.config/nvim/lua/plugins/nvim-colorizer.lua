return {
	"norcalli/nvim-colorizer.lua",
	lazy = true,
	event = "BufReadPre",
	opts = {
		filetypes = { "*", "!lazy" },
		user_default_options = {
			RGB = true, -- #RGB hex codes
			RRGGBB = true, -- #RRGGBB hex codes
			names = false, -- "Name" codes like Blue or blue
			RRGGBBAA = false, -- #RRGGBBAA hex codes
			AARRGGBB = false, -- 0xAARRGGBB hex codes
			rgb_fn = false, -- CSS rgb() and rgba() functions
			hsl_fn = false, -- CSS hsl() and hsla() functions
			css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			-- Available modes for `mode`: foreground, background,  virtualtext
			mode = "background", -- Set the display mode.
		},
		-- all the sub-options of filetypes apply to buftypes
		buftypes = {
			"*",
			-- exclude prompt and popup buftypes from highlight
			"!FZF",
			"!neo-tree",
			"!Outline",
			"!Trouble",
			"!alpha",
			"!lazy",
			"!neotest-summary",
			"!nofile",
			"!popup",
			"!prompt",
		},
	},
	config = function()
		require("colorizer").setup()
	end,
}
