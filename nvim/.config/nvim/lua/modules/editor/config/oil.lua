local setup = function()
  local oil = require("oil")
  oil.setup({
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    columns = { "icon" },
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<C-k>"] = false,
      ["<C-j>"] = false,
      ["<M-h>"] = "actions.select_split",
    },
    view_options = {
      show_hidden = true,
      natural_order = true,
      is_always_hidden = function(name, _)
        return name == ".." or name == ".git"
      end,
    },
    win_options = {
      wrap = true,
    },
  })

  local map = DV.map()
  local cmd = map.cmd

  map.n({
    ["-"] = cmd("Oil"),
    ["<leader>-"] = cmd("lua require('oil').toggle_float()<CR>"),
  })
end

return setup
