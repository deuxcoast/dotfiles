local package = DV.pack.package
local conf = require("modules.tools.config")

local map = DV.map()
local cmd = map.cmd
--------------------------------------------------------------------------------
-- Nvim-Colorizer
--------------------------------------------------------------------------------
package({
  "norcalli/nvim-colorizer.lua",
  event = "BufEnter",
  config = function()
    vim.opt.termguicolors = true
    require("colorizer").setup()
  end,
})

--------------------------------------------------------------------------------
-- Gx.nvim
--------------------------------------------------------------------------------
package({
  "chrishrb/gx.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true, -- default settings
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
  -- dev = true,
})

--------------------------------------------------------------------------------
-- Nvim-Surround
--------------------------------------------------------------------------------
package({
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- vim-sandwich keymaps
      keymaps = {
        -- add surrounding character
        normal = "sa",
        -- remove surrounding character
        delete = "sd",
        -- change surrounding character
        change = "sr",
      },
    })
  end,
})

--------------------------------------------------------------------------------
-- Nvim-Autopairs
--------------------------------------------------------------------------------
package({ "windwp/nvim-autopairs", event = "InsertEnter", config = conf.autopairs })

--------------------------------------------------------------------------------
-- Nvim-Ts-Autotag
--------------------------------------------------------------------------------
package({
  "windwp/nvim-ts-autotag",
  config = function()
    require("nvim-ts-autotag").setup({})
  end,
})

--------------------------------------------------------------------------------
-- Rainbow-Delimiters
--------------------------------------------------------------------------------
package({ "HiPhish/rainbow-delimiters.nvim", event = "BufEnter" })
package({
  "max397574/better-escape.nvim",
  config = function()
    require("better_escape").setup()
  end,
})

--------------------------------------------------------------------------------
-- Hop
--------------------------------------------------------------------------------
package({
  "phaazon/hop.nvim",
  opts = { jump_on_sole_occurrence = true },
  init = function()
    map.n({
      ["<leader>o"] = cmd("HopWord"),
      ["<leader>j"] = cmd("HopLineStartAC"),
      ["<leader>k"] = cmd("HopLineStartBC"),
    })
  end,
})

--------------------------------------------------------------------------------
-- Move
--------------------------------------------------------------------------------
package({
  "fedepujol/move.nvim",
  config = function()
    require("move").setup({})
    map.n({
      ["<M-j>"] = cmd("MoveLine (1)"),
      ["<M-k>"] = cmd("MoveLine (-1)"),
    })
    map.v({
      ["<M-j>"] = ":MoveBlock(1)<CR>",
      ["<M-k>"] = ":MoveBlock(-1)<CR>",
    })
  end,
})

--------------------------------------------------------------------------------
-- Small Tools
--------------------------------------------------------------------------------
package({ "rhysd/accelerated-jk", event = "BufEnter" })
package({ "hrsh7th/vim-eft", event = "BufEnter" })
package({ "mfussenegger/nvim-treehopper", event = "InsertEnter" })
package({
  "folke/todo-comments.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("todo-comments").setup()
  end,
})
