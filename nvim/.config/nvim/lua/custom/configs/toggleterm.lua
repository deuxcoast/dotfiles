local options = {
  open_mapping = [[<C-p>]],
  direction = "float",
  size = 20,
  insert_mappings = false,
  -- open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_terminals = false,
}

local terminal = require("toggleterm.terminal").Terminal
local lazygit = terminal:new {
   cmd = "lazygit",
   insert_mappings = false,
   dir = "git_dir",
   direction = "float",
   on_open = function(term)
      vim.cmd "startinsert!"
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
   end,
}

function Lazygit_toggle()
   lazygit:toggle()
end


return options

