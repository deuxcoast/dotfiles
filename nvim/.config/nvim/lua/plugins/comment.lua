return {
	"numToStr/Comment.nvim",
	dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	config = function()
		-- Setup numToStr/Comment.nvim to work with treesitter and "nvim-ts-context-commentstring"
		-- to support svelte files that contain multiple languages.
		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
