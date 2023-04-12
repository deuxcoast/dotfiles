local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
  },
  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  -- GIT PLUGINS
  -- Git Fugitive
  {
    "tpope/vim-fugitive",
    lazy = true,
    event = "VimEnter",
  },
  -- Close Buffers
  {
    "Asheq/close-buffers.vim",
    lazy = true,
    event = "BufEnter",
  },

  -- Floating Terminal
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    event = "VimEnter",
    opts = function()
      require "custom.configs.toggleterm"
    end,
    config = function(opts)
      require("toggleterm").setup(opts)
    end,
  },

  -- Editor Efficiency Plugins
  -- Tabout
  {
    "abecodes/tabout.nvim",
    lazy = true,
    event = "BufEnter",
    opts = function()
      require "custom.configs.tabout"
    end,
    config = function(opts)
      require("tabout").setup(opts)
    end,
  },

  {
    "phaazon/hop.nvim",
    lazy = true,
    event = "BufEnter",
    opts = function()
      require("custom.configs.hop")
    end,
    config = function(opts)
      require("hop").setup(opts)
    end,
  },
  {
    "tpope/vim-surround",
    lazy = true,
    event = "BufEnter",
  },
  {
    "RRethy/vim-illuminate",
    lazy = true,
    event = "BufEnter",
  },
  {
    "karb94/neoscroll.nvim",
    lazy = true,
    event = "BufEnter",
    opts = function()
      require("custom.configs.neoscroll")
    end,
    config = function(opts)
      require("neoscroll").setup(opts)
    end,
  },
  {
    "max397574/better-escape.nvim",
    lazy = true,
    event = "BufEnter",
    opts = function()
      require("custom.configs.better-escape")
    end,
    config = function(opts)
      require("better_escape").setup(opts)
    end,
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    lazy = true,
    event = "BufEnter",
  },
  {
    "hrsh7th/vim-eft",
    lazy = true,
    event = "BufEnter",
  },
  {
    "tpope/vim-unimpaired",
    lazy = true,
    event = "BufEnter",
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = true,
    event = "BufEnter",
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    event = "BufEnter",
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

}

return plugins
