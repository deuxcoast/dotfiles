return {
    "sudormrfbin/cheatsheet.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
    },
    bundled_cheatsheets = {
        disabled = { "nerd-fonts", "unicode", "markdown", "regex" },
    },
    -- For plugin specific cheatsheets
    bundled_plugin_cheatsheets = {
        enabled = { "gitsigns.nvim", "telescope.nvim" },
        disabled = {},
    },
}
