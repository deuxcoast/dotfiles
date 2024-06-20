return {
    "nvim-pack/nvim-spectre",
    config = function()
        require("spectre").setup {
            default = {
                find = {
                    cmd = "rg",
                },
                replace = {
                    cmd = "oxi",
                },
            },
        }
    end,
}
