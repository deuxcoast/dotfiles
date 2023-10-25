return {
    "ray-x/go.nvim",
    -- enabled = false,
    dependencies = "ray-x/guihua.lua",
    ft = "go",
    config = function()
        require("go").setup {
            comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. ﳑ
            verbose = false, -- output loginf in messages
            textobjects = true, -- enable default text objects through treesittter-text-objects
            test_runner = "go", -- richgo, go test, richgo, dlv, ginkgo
            luasnip = false,
            lsp_inlay_hints = {
                enable = false,
            },
            -- Disable everything for LSP
            lsp_cfg = false, -- true: apply go.nvim non-default gopls setup
            lsp_keymaps = false,
            lsp_codelens = false,
            lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
            lsp_on_attach = false, -- if a on_attach function provided:  attach on_attach function to gopls
            gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile", "/var/log/gopls.log" }
        }
    end,
}
