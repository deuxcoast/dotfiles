return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "RRethy/nvim-treesitter-textsubjects",
            "windwp/nvim-ts-autotag",
            -- 	-- [[ "nvim-treesitter/nvim-tree-docs", ]]
            -- "abecodes/tabout.nvim",
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "astro",
                    "bash",
                    "c",
                    "cpp",
                    "css",
                    "diff",
                    "dockerfile",
                    "gitignore",
                    "go",
                    "graphql",
                    "html",
                    "http",
                    "javascript",
                    "jsdoc",
                    "json",
                    "jsonc",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "prisma",
                    "python",
                    "query",
                    "regex",
                    "scss",
                    "svelte",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "sql",
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                autotag = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
                -- RRethy/nvim-treesitter-textsubjects
                textsubjects = {
                    enable = true,
                    prev_selection = "<S-CR>", -- (Optional) keymap to select the previous selection
                    keymaps = {
                        ["<CR>"] = "textsubjects-smart",
                        [";"] = "textsubjects-container-outer",
                        ["i;"] = "textsubjects-container-inner",
                    },
                },
                -- nvim-treesitter/nvim-treesitter-textobjects
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                },
            }
        end,
    },
    { "kana/vim-textobj-entire", dependencies = { "kana/vim-textobj-user" } }, -- select entire buffer
    { "kana/vim-textobj-line", dependencies = { "kana/vim-textobj-user" } }, -- select entire line
}
