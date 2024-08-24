local package = DV.pack.package
local conf = require("modules.ui.config")

--------------------------------------------------------------------------------
-- Alpha.nvim
--------------------------------------------------------------------------------
package({
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = conf.alpha,
})

--------------------------------------------------------------------------------
-- Heirline
-- Statusline designed around recursive inheritance
--------------------------------------------------------------------------------
package({
  "rebelot/heirline.nvim",
  config = conf.heirline,
  dependencies = {
    "davidosomething/everandever.nvim"
  }
})

--------------------------------------------------------------------------------
-- Which-Key
--------------------------------------------------------------------------------
package({
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      timeoutlen = 500,
      delay = 500,
      win = {
        border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
      },
    })
  end,
})
