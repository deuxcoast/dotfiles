return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup {
                signs = {
                    add = { text = "▎" },
                    change = { text = "▎" },
                    delete = { text = "" },
                    topdelete = { text = "" },
                    changedelete = { text = "" },
                    untracked = { text = "▎" },
                },
                on_attach = function(bufnr)
                    local function map(mode, lhs, rhs, opts)
                        opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
                        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
                    end

                    -- Navigation
                    map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
                    map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

                    -- Actions
                    map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>")
                    map("v", "<leader>hs", ":Gitsigns stage_hunk<CR>")
                    map("n", "<leader>hr", ":Gitsigns reset_hunk<CR>")
                    map("v", "<leader>hr", ":Gitsigns reset_hunk<CR>")
                    map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
                    map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
                    map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
                    map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
                    map("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>")
                    map("n", "<leader>hD", '<cmd>lua require"gitsigns".diffthis("~")<CR>')
                    map("n", "<leader>ht", "<cmd>Gitsigns toggle_deleted<CR>")

                    -- Text object
                    map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
                    map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")

                    -- Toggle current line blame
                    vim.keymap.set(
                        "n",
                        "<leader>tb",
                        ":Gitsigns toggle_current_line_blame<CR>",
                        { desc = "Toggle git current line blame" }
                    )
                end,
            }
        end,
    },
    {
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
            vim.keymap.set(
                "n",
                "<leader>gl",
                "<Esc>:Git log --stat %<CR>",
                { silent = true, desc = "Git log (buffer)" }
            )
            vim.keymap.set(
                "n",
                "<leader>gL",
                "<Esc>:Git log --stat -n 100<CR>",
                { silent = true, desc = "Git log (project)" }
            )
        end,
    },
}
