return {
    { "bluz71/vim-moonfly-colors", name = "moonfly" },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                flavor = "mocha",
                color_overrides = {
                    mocha = {
                        base = "#000000",
                        mantle = "#000000",
                        crust = "#000000",
                    },
                },
                highlight_overrides = {
                    mocha = function(mocha)
                        return {
                            AlphaHeader = { fg = mocha.green },
                            AlphaFooter = { fg = mocha.yellow },
                            GitSignsAdd = { fg = mocha.teal },
                            GitSignsDelete = { fg = mocha.red },
                            GitSignsChange = { fg = mocha.yellow },
                            WinSeparator = { fg = mocha.rosewater },
                            DiffAdd = { fg = mocha.mantle, bg = mocha.teal },
                            DiffDelete = { fg = mocha.mantle, bg = mocha.red },
                            DiffChange = { fg = mocha.mantle, bg = mocha.yellow },
                            DiffText = { fg = mocha.mantle, bg = mocha.pink },
                            DapStopped = { fg = mocha.blue, bg = mocha.mantle },
                            -- IblScope = { fg = mocha.lavender },
                        }
                    end,
                },
                no_italic = true,
                no_bold = true,
                integrations = {
                    alpha = true,
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    harpoon = true,
                    hop = true,
                    indent_blankline = {
                        enabled = true,
                        colored_indent_levels = true,
                    },
                    mason = true,
                    notify = true,
                    noice = true,
                    dap = {
                        enabled = true,
                        enable_ui = true, -- enable nvim-dap-ui
                    },
                    dap_ui = true,
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                        },
                        -- underlines = {
                        -- 	errors = { "underline" },
                        -- 	hints = { "underline" },
                        -- 	warnings = { "underline" },
                        -- 	information = { "underline" },
                        -- },
                        inlay_hints = {
                            background = true,
                        },
                    },
                    rainbow_delimiters = true,
                    telescope = {
                        enable = false,
                    },
                    lsp_trouble = true,
                },
            }
        end,
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        init = function()
            vim.cmd.highlight { "def link @function @function.builtin", bang = true }
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        -- priority = 1000,
        config = function()
            require("rose-pine").setup {
                --- @usage 'auto'|'main'|'moon'|'dawn'
                variant = "auto",
                --- @usage 'main'|'moon'|'dawn'
                dark_variant = "main",
                bold_vert_split = false,
                dim_nc_background = false,
                disable_background = false,
                disable_float_background = false,
                disable_italics = true,
                --- @usage string hex value or named color from rosepinetheme.com/palette
                groups = {
                    background = "base",
                    background_nc = "_experimental_nc",
                    panel = "surface",
                    panel_nc = "base",
                    border = "highlight_med",
                    comment = "muted",
                    link = "iris",
                    punctuation = "subtle",

                    error = "love",
                    hint = "iris",
                    info = "foam",
                    warn = "gold",

                    headings = {
                        h1 = "iris",
                        h2 = "foam",
                        h3 = "rose",
                        h4 = "gold",
                        h5 = "pine",
                        h6 = "foam",
                    },
                    -- or set all headings at once
                    -- headings = 'subtle'
                },

                -- Change specific vim highlight groups
                -- https://github.com/rose-pine/neovim/wiki/Recipes
                highlight_groups = {
                    -- ColorColumn = { bg = "rose" },

                    -- Blend colours against the "base" background
                    CursorLine = { bg = "foam", blend = 10 },
                    StatusLine = { fg = "love", bg = "love", blend = 10 },

                    -- By default each group adds to the existing config.
                    -- If you only want to set what is written in this config exactly,
                    -- you can set the inherit option:
                    Search = { bg = "gold", inherit = false },
                },
            }
        end,
    },
    {
        "sainnhe/gruvbox-material",
        -- lazy = false,
        -- priority = 1000,
    },
}
