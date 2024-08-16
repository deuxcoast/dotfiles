return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-dap.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            "benfowler/telescope-luasnip.nvim",
            "folke/trouble.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        init = function()
            local set_mappings = require "config.telescope.mappings"
            set_mappings()
        end,
        config = function()
            local telescope = require "telescope"
            local telescope_config = require "telescope.config"

            -- Clone the default Telescope configuration
            local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

            -- I want to search in hidden/dot files.
            table.insert(vimgrep_arguments, "--hidden")
            -- I don't want to search in the `.git` directory.
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")

            local trouble_present, trouble = pcall(require, "trouble.providers.telescope")
            if not trouble_present then
                print "trouble is not installed"
            end

            telescope.setup {
                defaults = {
                    -- `hidden = true` is not supported in text grep commands.
                    vimgrep_arguments = vimgrep_arguments,
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.90,
                        height = 0.85,
                        -- preview_cutoff = 120,
                        prompt_position = "bottom",

                        horizontal = {
                            preview_width = function(_, cols, _)
                                if cols > 200 then
                                    return math.floor(cols * 0.4)
                                else
                                    return math.floor(cols * 0.6)
                                end
                            end,
                        },

                        vertical = {
                            width = 0.9,
                            height = 0.95,
                            preview_height = 0.5,
                        },

                        flex = {
                            horizontal = {
                                preview_width = 0.9,
                            },
                        },
                    },

                    selection_strategy = "reset",
                    sorting_strategy = "descending",
                    scroll_strategy = "cycle",
                    color_devicons = true,
                },
                mappings = {
                    n = {
                        ["<c-c>"] = require("telescope.actions").close,
                    },
                },
                pickers = {
                    find_files = {
                        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    },
                    colorscheme = {
                        ignore_builtins = true,
                        enable_preview = true,
                    },
                },
            }

            -- vim.defer_fn(function()
            --     telescope.load_extension "fzf"
            --     telescope.load_extension "file_browser"
            --     telescope.load_extension "live_grep_args"
            --     telescope.load_extension "make"
            --     telescope.load_extension "termfinder"
            --     telescope.load_extension "noice"
            --     telescope.load_extension "luasnip"
            -- end, 1000)
        end,
    },
    -- {
    --     "sopa0/telescope-makefile",
    --     event = "VeryLazy",
    --     config = function()
    --         require("telescope-makefile").setup {
    --             -- The path where to search the makefile in the priority order
    --             makefile_priority = { ".", "build/" },
    --             default_target = "[DEFAULT]", -- nil or string : Name of the default target | nil will disable the default_target
    --             make_bin = "make", -- Custom makefile binary path, uses system make by def
    --         }
    --     end,
    -- },
}
