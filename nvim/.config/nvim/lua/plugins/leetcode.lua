return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    enabled = false,

    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",

        -- optional
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    cmd = "Leet",
    opts = {
        lang = "golang",
        injector = {
            ["golang"] = {
                before = { "package leetcode" },
            },
        },
    },
}
