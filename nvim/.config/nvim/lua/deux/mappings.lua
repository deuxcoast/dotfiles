local map = require("deux.utils.keymap")
local cmd = map.cmd

map.i({
	["<C-h>"] = "<Left>",
	["<C-l>"] = "<Right>",
	["<C-k>"] = "<Up>",
	["<C-j>"] = "<Down>",
	["<S-return>"] = "<ESC>A<CR>",
	["<C-return>"] = "<ESC>O",
}, { remap = true })

map.n({
	["<leader>w"] = ":w<CR>",
	["<leader>uh"] = ":noh<CR>",
})

map.n({
	-- ["<C-n>"] = cmd("bn"), -- go to next buffer
	-- ["<C-p>"] = cmd("bp"), -- go to prev buffer
	["<C-q>"] = cmd("qa!"), -- quit all
})

-- Comments
map.n("g;", "gcc", { remap = true })
map.v("g;", "gc", { remap = true })

-- Create space on line above/below
map.n({
	["<leader>kk"] = "<Plug>(unimpaired-blank-up)",
	["<leader>jj"] = "<Plug>(unimpaired-blank-down)",
})

-- Navigate in terminal mode
map.t({
	["<C-k>"] = "<C-\\><C-n><C-w>k",
	["<C-j>"] = "<C-\\><C-n><C-w>j",
	["<C-h>"] = "<C-\\><C-n><C-w>h",
	["<C-l>"] = "<C-\\><C-n><C-w>l",
	["jk"] = "<C-\\><C-n>",
})

-- Saner behavior of n and N
-- map.nxo({
--   ["n"] =
-- })
--
