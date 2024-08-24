local package = DV.pack.package
local conf = require("modules.tools.config")

local map = DV.map()
local cmd = map.cmd
--------------------------------------------------------------------------------
-- Nvim-Colorizer
-- Provides highlights for hex colors in text
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
-- Gx will open plugins, docs, links, etc in browser
--------------------------------------------------------------------------------
package({
  "chrishrb/gx.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true, -- default settings
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
  dev = true,
})

--------------------------------------------------------------------------------
-- Nvim-Surround
-- Functions and keymaps for dealing with surrounding characters
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
-- Intelligently provides closing parens, brackets, etc.
--------------------------------------------------------------------------------
package({ "windwp/nvim-autopairs", event = "InsertEnter", config = conf.autopairs })

--------------------------------------------------------------------------------
-- Nvim-Ts-Autotag
-- Use treesitter to auto close and auto rename html tag
--------------------------------------------------------------------------------
package({
  "windwp/nvim-ts-autotag",
  config = function()
    require("nvim-ts-autotag").setup({})
  end,
})

--------------------------------------------------------------------------------
-- Rainbow-Delimiters
-- Rainbow parentheses using treesitter
--------------------------------------------------------------------------------
package({
  "HiPhish/rainbow-delimiters.nvim",
  event = "BufEnter",
  config = function()
    require("rainbow-delimiters.setup").setup({
      highlight = {
        -- change the order in which the rainbow delimiters highlight groups
        -- are utilized
        -- 'RainbowDelimiterRed',
        -- 'RainbowDelimiterYellow',
        -- 'RainbowDelimiterBlue',
        -- 'RainbowDelimiterOrange',
        -- 'RainbowDelimiterGreen',
        -- 'RainbowDelimiterViolet',
        -- 'RainbowDelimiterCyan',
      }
    })
  end
})

--------------------------------------------------------------------------------
-- Better-Escape
-- Provides `jk` keymap for leaving insert mode without delaying input of `j`
--------------------------------------------------------------------------------
package({
  "max397574/better-escape.nvim",
  config = function()
    require("better_escape").setup({
      mappings = {
        v = {
          j = {
            k = false,
          },
        },
      }
    })
  end,
})

--------------------------------------------------------------------------------
-- Hop
-- Provides motions for hopping around the buffer
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
-- Move lines and blocks of text, with ato indentation
--------------------------------------------------------------------------------
package({
  "fedepujol/move.nvim",
  config = function()
    require("move").setup({})
    map.n({
      ["<M-k>"] = cmd("MoveLine (-1)"),
      ["<M-j>"] = cmd("MoveLine (1)"),
    })
    map.v({
      ["<M-j>"] = ":MoveBlock(1)<CR>",
      ["<M-k>"] = ":MoveBlock(-1)<CR>",
    })
  end,
})

--------------------------------------------------------------------------------
-- Vim-eft
-- Better f/t/F/T mappings that provide highlights
--------------------------------------------------------------------------------
package({
  "hrsh7th/vim-eft",
  event = "BufEnter",
  config = function()
    map.nxo({
      [";"] = "<Plug>(eft-repeat)",
      ["f"] = "<Plug>(eft-f)",
      ["F"] = "<Plug>(eft-F)",
      ["t"] = "<Plug>(eft-t)",
      ["T"] = "<Plug>(eft-T)",
    })
  end
})

--------------------------------------------------------------------------------
-- Nvim-Treehopper
-- Region selection in visual mode, using TS nodes and movements from `hop.nvim`
--------------------------------------------------------------------------------
package({
  "mfussenegger/nvim-treehopper",
  event = "InsertEnter",
  config = function()
    map.o("m", ":<C-U> lua require('tsht').nodes()<CR>", { remap = true })
    map.x("m", ":lua require('tsht').nodes()<CR>")
  end
})

--------------------------------------------------------------------------------
-- Todo-Comments
-- -
--------------------------------------------------------------------------------
package({
  "folke/todo-comments.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("todo-comments").setup()
  end,
})

package({ "tpope/vim-unimpaired" })

package({
  "SmiteshP/nvim-navic",
  config = function()
    require("nvim-navic").setup({
      lsp = {
        auto_attach = true,
      }
    })
  end
})

-- package({ "chaoren/vim-wordmotion" })
