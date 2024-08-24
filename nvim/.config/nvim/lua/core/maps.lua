local map = DV.map()
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
  ["<C-n>"] = cmd("bn"),  -- go to next buffer
  ["<C-p>"] = cmd("bp"),  -- go to prev buffer
  ["<C-q>"] = cmd("qa!"), -- quit all
})

-- Comments
map.n("<leader>/", "gcc", { remap = true })
map.v("<leader>/", "gc", { remap = true })

-- Create space on line above/below
map.n({
  ["<leader>kk"] = "<Plug>(unimpaired-blank-up)",
  ["<leader>jj"] = "<Plug>(unimpaired-blank-down)",
})
