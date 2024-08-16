local mappings = function()
    local finders = require "config.telescope.custom-finders"

    vim.keymap.set("n", "<leader><leader>", ":Telescope find_files<CR>", { desc = " Project files" })
    vim.keymap.set("n", "<leader>f/", ":Telescope current_buffer_fuzzy_find<CR>", { desc = " Current buffer fzf" })
    vim.keymap.set("n", "<leader>;", ":Telescope current_buffer_fuzzy_find<CR>", { desc = " Current buffer fzf" })
    vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = " Buffers" })
    vim.keymap.set("n", "<leader>ff", function()
        finders.project_files()
    end, { desc = " Git files", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = " Project grep" })
    -- vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
    vim.keymap.set("n", "<leader>fG", ":Telescope grep_string<CR>", { desc = " String under cursor" })
    vim.keymap.set(
        "n",
        "<leader>fo",
        "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>",
        { desc = " File browser" }
    )
    vim.keymap.set("n", "<leader>fT", ":Telescope builtin<CR>", { desc = " Telescope meta" })
    vim.keymap.set("n", "<leader>fr", ":Telescope lsp_references<CR>", { desc = " LSP symbol references" })
    vim.keymap.set("n", "<leader>fl", ":Telescope loclist<CR>", { desc = " loclist" })
    vim.keymap.set("n", "<leader>fi", ":Telescope lsp_implementations<CR>", { desc = " symbol implementation" })
    vim.keymap.set("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", { desc = " LSP document symbols" })
    vim.keymap.set("n", "<leader>fc", ":Telescope git_bcommits<CR>", { desc = " Buffer git commit history" })
    vim.keymap.set("n", "<leader>fC", ":Telescope git_commits<CR>", { desc = " Project git commit history" })
    vim.keymap.set("n", "<leader>fM", ":Telescope make<CR>", { desc = " Makefile" })
    vim.keymap.set("n", "<leader>ft", ":Telescope termfinder find<CR>", { desc = " Terminals" })
    vim.keymap.set("n", "<leader>fm", ":Telescope noice<CR>", { desc = " Messages" })
    vim.keymap.set("n", "<leader>fk", ":Telescope man_pages sections=ALL<CR>", { desc = " Man pages" })
    vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = " Help tags" })
    vim.keymap.set("n", "<leader>fs", ":Telescope colorscheme<CR>", { desc = " Color schemes" })
    vim.keymap.set("n", "<leader>fa", ":Cheatsheet<CR>", { desc = " Cheatsheet keymaps" })
    vim.keymap.set("n", "<leader>fS", ":Telescope luasnip<CR>", { desc = " LuaSnip" })
    vim.keymap.set("n", "<leader>fd", ":Telescope lsp_document_symbols<CR>", { desc = " LSP document symbols" })
    vim.keymap.set("n", "<leader>fw", ":Telescope lsp_workspace_symbols<CR>", { desc = " LSP workspace symbols" })
end

return mappings
