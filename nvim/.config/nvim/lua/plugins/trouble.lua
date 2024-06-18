return {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
        {
            "<leader>lw",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>ld",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer diagnostics (Trouble)",
        },
        {
            "<leader>lr",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>ll",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location list (Trouble)",
        },
        {
            "<leader>lq",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
}
