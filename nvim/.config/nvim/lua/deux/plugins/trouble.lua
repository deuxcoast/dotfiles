local map = require("deux.utils.keymap")
local cmd = map.cmd

local trouble_keys = {
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

}
return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = trouble_keys,
  config = function()
    require("trouble").setup({})

    map.n({
      ["<leader>lw"] = cmd("Trouble diagnostics toggle"),
      ["<leader>ld"] = cmd("Trouble diagnostics toggle filter.buf=0"),
      ["<leader>lr"] = cmd("Trouble lsp toggle focus=false win.position=right"),
      ["<leader>ll"] = cmd("Trouble loclist toggle"),
      ["<leader>lq"] = cmd("Trouble qflist toggle"),
    })
  end
}
