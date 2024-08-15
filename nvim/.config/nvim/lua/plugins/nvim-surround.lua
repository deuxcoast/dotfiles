return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup {
            -- vim-sandwich keymaps
            keymaps = {
                -- add surrounding character
                normal = "sa",
                -- remove surrounding character
                delete = "sd",
                -- change surrounding character
                change = "sr",
            },
        }
    end,
}
