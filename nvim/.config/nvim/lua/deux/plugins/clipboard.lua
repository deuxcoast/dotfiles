return {
	{
		"gbprod/yanky.nvim",
		config = function()
			require("yanky").setup({
				highlight = {
					timer = 200,
				},
			})

			local map = require("deux.utils.keymap")

			map.nx({
				["p"] = "<Plug>(YankyPutAfter)",
				["P"] = "<Plug>(YankyPutBefore)",
				["gp"] = "<Plug>(YankyGPutAfter)",
				["gP"] = "<Plug>(YankyGPutBefore)",
			})

			map.n({
				["<S-K>"] = "<Plug>(YankyPreviousEntry)",
				["<S-J>"] = "<Plug>(YankyNextEntry)",
			})
		end
	},
}
