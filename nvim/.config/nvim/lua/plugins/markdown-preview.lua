return {
    {
        "plasticboy/vim-markdown",
        branch = "master",
        require = { "godlygeek/tabular" },
    },
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
        ft = "markdown",
        init = function()
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_browser = "chrome"

            vim.keymap.set("n", "<leader>zp", ":MarkdownPreviewToggle<CR>", { desc = "Toggle markdown preview" })
        end,
    },
}
