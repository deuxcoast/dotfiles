-- easy-motion alternative
return {
	"phaazon/hop.nvim",
	opts = { jump_on_sole_occurrence = true },
	init = function()
		vim.keymap.set("n", "<Leader>o", "<cmd>HopWord<CR>", { desc = "Hop to any word" })
		vim.keymap.set("n", "<Leader>j", "<cmd>HopLineStartAC<CR>", { desc = "Hop to line down" })
		vim.keymap.set("n", "<Leader>k", "<cmd>HopLineStartBC<CR>", { desc = "Hop to line up" })
	end,
}
