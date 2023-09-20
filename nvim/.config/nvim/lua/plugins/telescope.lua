return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-dap.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            -- "nvim-telescope/telescope-hop.nvim", -- TEST: Is this downloaded by Lazy? Do I need to provide it elsewhere?
            "folke/trouble.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "natecraddock/workspaces.nvim",
            "sopa0/telescope-makefile",
            "tknightz/telescope-termfinder.nvim",
        },
        init = function()
            vim.keymap.set("n", "<leader><leader>", ":Telescope git_files<CR>", { desc = " Git files" })
            vim.keymap.set(
                "n",
                "<leader>f/",
                ":Telescope current_buffer_fuzzy_find<CR>",
                { desc = " Current buffer fzf" }
            )
            vim.keymap.set(
                "n",
                "<leader>;",
                ":Telescope current_buffer_fuzzy_find<CR>",
                { desc = " Current buffer fzf" }
            )
            vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = " Buffers" })
            vim.keymap.set("n", "<leader>b", ":Telescope buffers<CR>", { desc = " Buffers" })
            vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = " Project files" })
            vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = " Project grep" })
            -- vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
            vim.keymap.set("n", "<leader>fG", ":Telescope grep_string<CR>", { desc = " String under cursor" })
            vim.keymap.set(
                "n",
                "<leader>fo",
                "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>",
                { desc = " File browser" }
            )
            vim.keymap.set("n", "<leader>fT", ":Telescope builtin<CR>", { desc = " Telescope meta" })
            vim.keymap.set("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", { desc = " LSP document symbols" })
            vim.keymap.set("n", "<leader>fc", ":Telescope git_bcommits<CR>", { desc = " Buffer git commit history" })
            vim.keymap.set("n", "<leader>fC", ":Telescope git_commits<CR>", { desc = " Project git commit history" })
            vim.keymap.set("n", "<leader>fw", ":Telescope workspaces<CR>", { desc = " Workspaces" })
            vim.keymap.set("n", "<leader>fM", ":Telescope make<CR>", { desc = " Makefile" })
            vim.keymap.set("n", "<leader>ft", ":Telescope termfinder find<CR>", { desc = " Terminals" })
            vim.keymap.set("n", "<leader>fm", ":Telescope noice<CR>", { desc = " Messages" })
            vim.keymap.set("n", "<leader>fk", ":Telescope man_pages sections=ALL<CR>", { desc = " Man pages" })
            vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = " Help tags" })
            vim.keymap.set("n", "<leader>fs", ":Telescope colorscheme<CR>", { desc = " Color schemes" })
        end,
        config = function()
            local telescope = require("telescope")

            local trouble_present, trouble = pcall(require, "trouble.providers.telescope")
            if not trouble_present then
                print("trouble is not installed")
            end

            telescope.setup({
                extensions = {
                    file_browser = {
                        theme = "ivy",
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                    termfinder = {
                        mappings = {},
                    },
                },
                defaults = {
                    mappings = {
                        n = {
                            ["<c-c>"] = require("telescope.actions").close,
                        },
                    },
                },
            })

            telescope.load_extension("fzf")
            telescope.load_extension("file_browser")
            telescope.load_extension("ui-select")
            telescope.load_extension("workspaces")
            telescope.load_extension("live_grep_args")
            telescope.load_extension("make")
            telescope.load_extension("termfinder")
            telescope.load_extension("noice")
        end,
    },
    {
        "sopa0/telescope-makefile",
        config = function()
            require("telescope-makefile").setup({
                -- The path where to search the makefile in the priority order
                makefile_priority = { ".", "build/" },
                default_target = "[DEFAULT]", -- nil or string : Name of the default target | nil will disable the default_target
                make_bin = "make", -- Custom makefile binary path, uses system make by def
            })
        end,

    }
}
