local function db_completion()
    require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
end
return {
    "tpope/vim-dadbod",
    dependencies = {
        { "kristijanhusak/vim-dadbod-ui" },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
    },
    init = function()
        vim.keymap.set("n", "<leader>uu", "<Cmd>DBUIToggle<Cr>", { silent = true, desc = "DB UI Toggle" })
        vim.keymap.set("n", "<leader>uf", "<Cmd>DBUIFindBuffer<Cr>", { silent = true, desc = "DB UI Find Buffer" })
        vim.keymap.set("n", "<leader>ur", "<Cmd>DBUIRenameBuffer<Cr>", { silent = true, desc = "DB UI Rename Buffer" })
        vim.keymap.set(
            "n",
            "<leader>ur",
            "<Cmd>DBUILastQueryInfo<Cr>",
            { silent = true, desc = "DB UI Last Query Info" }
        )
    end,
    config = function()
        vim.g.db_ui_show_help = 0
        vim.g.db_ui_win_position = "right"
        vim.g.db_ui_use_nerd_fonts = 1

        vim.g.db_ui_save_location = "~/.config/nvim/db_ui"

        vim.g.db_ui_hide_schemas = { "pg_toast_temp.*" }
    end,
}
