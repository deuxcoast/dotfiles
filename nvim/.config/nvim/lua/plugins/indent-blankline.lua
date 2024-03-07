return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }

        local mocha = require("catppuccin.palettes").get_palette "mocha"
        local hooks = require "ibl.hooks"

        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = mocha.base })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = mocha.yellow })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = mocha.blue })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = mocha.pink })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = mocha.teal })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = mocha.lavender })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = mocha.mauve })
        end)

        hooks.register(hooks.type.ACTIVE, function(bufnr)
            return vim.tbl_contains(
                { "yaml", "html", "svelte", "json" },
                vim.api.nvim_get_option_value("filetype", { buf = bufnr })
            )
        end)

        require("ibl").setup {
            indent = {
                char = "▏",
                highlight = highlight,
            },
            scope = {
                enabled = false,
                show_start = false,
            },
        }
    end,
}
