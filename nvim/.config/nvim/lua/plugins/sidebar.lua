return {
    "sidebar-nvim/sidebar.nvim",
    init = function()
        vim.keymap.set("n", "<leader>xs", ":SidebarNvimToggle<CR>", { desc = "Toggle Sidebar" })
    end,
    config = function()
        require("sidebar-nvim").setup {
            sections = { "diagnostics", "symbols", "todos" },
        }
    end,
}
