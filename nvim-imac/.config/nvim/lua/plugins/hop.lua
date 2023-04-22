-- easy-motion alternative
return {
	"phaazon/hop.nvim",
	opts = { jump_on_sole_occurrence = true },
	init = function()
		vim.keymap.set("n", "<Leader>o", "<cmd>HopWord<CR>")
		vim.keymap.set("n", "<Leader>j", "<cmd>HopLineStartAC<CR>")
		vim.keymap.set("n", "<Leader>k", "<cmd>HopLineStartBC<CR>")
	end,
}
