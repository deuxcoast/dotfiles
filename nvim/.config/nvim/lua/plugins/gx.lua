return {
    "chrishrb/gx.nvim",
    cmd = { "Browse" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true, -- default settings
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    dev = true,
}
