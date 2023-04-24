vim.g.mapleader = " "

-- closing  and quitting
-- vim.keymap.set("n", "<leader>q"
-- Quit vim
vim.keymap.set("n", "<leader>Q", ":qall <CR>")
-- Close the current window
vim.keymap.set("n", "<leader>qw", ":close<CR>")

-- Splits
vim.keymap.set("n", "<leader>sv", "<C-w>v")
vim.keymap.set("n", "<leader>sh", "<C-w>s")

--- CLIPBOARD
-- copy to OS clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+yy')
-- paste from OS clipboard
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>P", '"+P"`"`"')
-- delete to OS clipboard
vim.keymap.set("v", "<leader>d", '"+d')

-- Toggle comment

vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)")

-- nvigate within insert mode
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-j>", "<C-o>j")
-- maybe being overwritten by autoclose plugin?
-- :verbose imap <C-H>
vim.keymap.set("i", "<C-h>", "<C-o>h")

-- switch between windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- go  to beginning / end in insert mode
vim.keymap.set("i", "<C-e>", "<end>")
vim.keymap.set("i", "<C-b>", "<ESC>^i")

-- unhighlight
vim.keymap.set("n", "<leader>uh", ":noh <CR>")

vim.keymap.set("v", "p", '"_dP"')           -- don't yank replaced text

vim.keymap.set("n", "<leader>we", ":x<CR>") -- save and close
vim.keymap.set("n", "<leader>w", ":w<CR>")  -- save
vim.keymap.set("n", "<A-q>", ":q!<CR>")     -- close w/o saving

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Vim-eft
vim.keymap.set("n", "f", "<Plug>(eft-f)")
vim.keymap.set("n", "F", "<Plug>(eft-F)")
vim.keymap.set("n", "t", "<Plug>(eft-t)")
vim.keymap.set("n", "T", "<Plug>(eft-T)")

-- Nvim-Tree
vim.keymap.set("n", "<leader>e", "<CMD> NvimTreeFocus <CR>")
vim.keymap.set("n", "<C-m>", "<CMD> NvimTreeToggle <CR>")
-- Tree Hopper for visual selection by treesitter nodes
vim.keymap.set("v", "m", ":lua require('tsht').nodes()<CR>")
-- Navigate windows
-- vim.keymap.set("n", "<C-l>")

-- Visual Multi

-- Navigate buffers
vim.keymap.set("n", "<C-Right>", ":bnext<CR>")
vim.keymap.set("n", "<C-Left>", ":bprevious<CR>")

-- Tabs
vim.keymap.set("n", "<S-l>", ":tabnext<CR>")
vim.keymap.set("n", "<S-h>", ":tabprevious<CR>")
vim.keymap.set("n", "<C-t>n", ":tabnew<CR>")

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<F8>", function()
    require("null-ls").toggle("cspell")
end)

-- Center screen after vertical movements
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Better up/down
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

local map = vim.api.nvim_set_keymap

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

map("n", "<C-j>", "<Plug>(unimpaired-move-down)", { desc = "move current line down" })
map("n", "<C-k>", "<Plug>(unimpaired-move-up)", { desc = "move current line down" })
map("n", "<leader>jj", "<Plug>(unimpaired-blank-down)", { desc = "insert blank line above current line" })
map("n", "<leader>kk", "<Plug>(unimpaired-blank-up)", { desc = "insert blank line above current line" })

-- save and source
vim.keymap.set("n", "<leader>cx", function()
    vim.cmd("w")
    vim.cmd("so %")
end)

-- aerial

-- toggle foldmethod
-- vim.keymap.set("n", "yof", function()
-- 	if vim.opt.foldmethod:get() == "expr" then
-- 		vim.cmd([[set foldmethod=manual]])
-- 		print("set foldmethod=manual")
-- 	else
-- 		vim.cmd([[set foldmethod=expr]])
-- 		print("set foldmethod=expr")
-- 	end
-- end)

-- Close dap float windows and quickfix with q and Esc.
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf", "dap-float" },
    callback = function()
        vim.keymap.set("n", "q", "<cmd>close!<CR>", { silent = true, buffer = true })
        vim.keymap.set("n", "<Esc>", "<cmd>close!<CR>", { silent = true, buffer = true })
    end,
})
