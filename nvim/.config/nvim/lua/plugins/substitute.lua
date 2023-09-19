return {
	"gbprod/substitute.nvim",
	init = function()
		-- Substitute operator
		vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
		vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
		vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
		vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })

		-- Exchange operator
		vim.keymap.set("n", "sx", require("substitute.exchange").operator, { noremap = true })
		vim.keymap.set("n", "sxx", require("substitute.exchange").line, { noremap = true })
		vim.keymap.set("x", "X", require("substitute.exchange").visual, { noremap = true })
		vim.keymap.set("n", "sxc", require("substitute.exchange").cancel, { noremap = true })
	end,
	config = function()
		require("substitute").setup({})
	end,
}
