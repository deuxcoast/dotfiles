return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "kyazdani42/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		require("fzf-lua").setup({})
	end,
}
