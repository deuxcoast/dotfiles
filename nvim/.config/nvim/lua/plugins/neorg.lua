return {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    -- put any other flags you wanted to pass to lazy here!
    config = function()
        require("neorg").setup {
            ..., -- put any of your previous config here
        }
    end,
}
