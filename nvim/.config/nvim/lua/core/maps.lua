local map = DV.map()
local cmd = map.cmd

map.i({
  ["jk"] = "<ESC>",
  ["<C-h>"] = "<Left>",
  ["<C-l>"] = "<Right>",
  ["<C-k>"] = "<Up>",
  ["<C-j>"] = "<Down>",
}, { remap = true })

map.n({
  ["<leader>w"] = ":w<CR>",
  ["<leader>uh"] = ":noh<CR>",
})

map.n({
  ["<C-n>"] = cmd("bn"), -- go to next buffer
  ["<C-p>"] = cmd("bp"), -- go to prev buffer
  ["<C-q>"] = cmd("qa!"), -- quit all
})

-- Comments
map.n("<leader>/", "gcc", { remap = true })
map.v("<leader>/", "gc", { remap = true })
