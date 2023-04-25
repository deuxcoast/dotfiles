return {
	"ray-x/go.nvim",
	dependencies = "ray-x/guihua.lua",
	ft = "go",
	init = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.go" },
			group = vim.api.nvim_create_augroup("OrganizeImports", {}),
			callback = function()
				vim.cmd("GoImport")
			end,
		})
	end,
	config = function()
		require("go").setup({
			comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. ﳑ
			verbose = false, -- output loginf in messages
			textobjects = true, -- enable default text jobects through treesittter-text-objects
			test_runner = "go", -- richgo, go test, richgo, dlv, ginkgo
		})
	end,
}
