return {
    "tpope/vim-fugitive",
    init = function()
        vim.keymap.set("n", "<leader>G", "<Esc>:Git<CR>", { silent = true, desc = "Git" })
        vim.keymap.set("n", "<leader>gr", "<Esc>:Gread<CR>", { silent = true, desc = "Gread (reset)" })
        vim.keymap.set("n", "<leader>gw", "<Esc>:Gwrite<CR>", { silent = true, desc = "Gwrite (stage)" })
        vim.keymap.set("n", "<leader>gb", "<Esc>:Git blame<CR>", { silent = true, desc = "git blame" })
        -- vim.keymap.set("n", "<leader>gc", "<Esc>:Git commit<CR>", { silent = true })
        vim.keymap.set("n", "<leader>gd", "<Esc>:Gvdiffsplit!<CR>", { silent = true, desc = "Git diff (buffer)" })
        vim.keymap.set("n", "<leader>gD", "<Esc>:Git diff<CR>", { silent = true, desc = "Git diff (project)" })
        vim.keymap.set("n", "<leader>gp", "<Esc>:Git push<CR>", { silent = true, desc = "Git push" })
        vim.keymap.set("n", "<leader>gP", "<Esc>:Git pull<CR>", { silent = true, desc = "Git pull" })
        vim.keymap.set("n", "<leader>g-", "<Esc>:Git stash push<CR>", { silent = true, desc = "Git stash push" })
        vim.keymap.set("n", "<leader>g+", "<Esc>:Git stash pop<CR>", { silent = true, desc = "Git stash pop" })
        vim.keymap.set("n", "<leader>gl", "<Esc>:Git log --stat %<CR>", { silent = true, desc = "Git log (buffer)" })
        vim.keymap.set(
            "n",
            "<leader>gL",
            "<Esc>:Git log --stat -n 100<CR>",
            { silent = true, desc = "Git log (project)" }
        )
    end,
}
