return {
	"folke/trouble.nvim",
	init = function()
		vim.keymap.set("n", "<leader>lo", "<cmd>TroubleToggle<cr>")
		vim.keymap.set("n", "<leader>lw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
		vim.keymap.set("n", "<leader>ld", "<cmd>TroubleToggle document_diagnostics<cr>")
		vim.keymap.set("n", "<leader>lq", "<cmd>TroubleToggle quickfix<cr>")
		vim.keymap.set("n", "<leader>ll", "<cmd>TroubleToggle loclist<cr>")
		vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>")
	end,
	config = function()
		require("trouble").setup({})
	end,
}
