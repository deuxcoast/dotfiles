return {
    { "HiPhish/rainbow-delimiters.nvim" },
    {
        "kazhala/close-buffers.nvim",
        config = function()
            vim.keymap.set("n", "<leader>q", function()
                require("close_buffers").delete { type = "this" } -- Delete the current buffer
            end)
        end,
    },
    { "nvim-lua/plenary.nvim" }, -- useful lua functions
    { "tjdevries/green_light.nvim" },
    { "tpope/vim-rhubarb" },
    { "tpope/vim-unimpaired" },
    { "godlygeek/tabular" }, -- Quickly align text by pattern
    { "sindrets/diffview.nvim", opts = { file_panel = { win_config = { position = "left" } } } },
    { "rhysd/accelerated-jk", event = "BufEnter" },
    {
        "max397574/better-escape.nvim",
        event = "BufEnter",
        config = function()
            require("better_escape").setup()
        end,
    },
    { "hrsh7th/vim-eft", event = "BufEnter" },
    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.dashboard").config)
        end,
    },
    {
        "szw/vim-maximizer",
        event = "BufEnter",
        init = function()
            vim.keymap.set("n", "<leader>mm", ":MaximizerToggle!<CR>")
        end,
    },
    {
        "gabrielpoca/replacer.nvim",
        init = function()
            vim.api.nvim_set_keymap("n", "<Leader>gr", ':lua require("replacer").run()<cr>', { silent = true })
        end,
    },
    { "mbbill/undotree", event = "BufEnter" },
    { "mfussenegger/nvim-treehopper", event = "InsertEnter" },
    { "nvim-tree/nvim-web-devicons" },
    { "RishabhRD/nvim-cheat.sh", dependencies = "RishabhRD/popfix" },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    { "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", config = true },
    { "mattn/emmet-vim", lazy = true, event = "BufEnter" },
    { "fedepujol/move.nvim", lazy = true, event = "BufEnter" },
    { "vim-scripts/ReplaceWithRegister", lazy = true, event = "BufEnter" },
    {
        "ellisonleao/glow.nvim",
        config = function()
            require("glow").setup {
                width = 100,
            }
        end,
        cmd = "Glow",
    },
}
