return {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
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
