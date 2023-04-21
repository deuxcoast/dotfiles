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
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "custom.configs.null-ls"
    end,
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },
  {
    "numToStr/Comment.nvim",
    opts = overrides.comment,
  },
  -- Treesitter

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    dependencies = {
      { "abecodes/tabout.nvim" },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      { "nvim-treesitter/nvim-treesitter-context" },
      { "mfussenegger/nvim-treehopper" },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "andymass/vim-matchup" },
      { "windwp/nvim-ts-autotag" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
  -- {
  --   "abecodes/tabout.nvim",
  --   opts = function()
  --     require "custom.configs.tabout"
  --   end,
  --   config = function(opts)
  --     require("tabout").setup(opts)
  --   end,
  -- },
  {
    "mfussenegger/nvim-treehopper",
    config = function()
      vim.cmd [[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
      vim.cmd [[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  {
    "andymass/vim-matchup",
  },
  {
    "windwp/nvim-ts-autotag",
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
 --  {
 --    "ray-x/go.nvim",
 --    dependencies = {
 --      "ray-x/guihua.lua",
 --      "neovim/nvim-lspconfig",
 --      "nvim-treesitter/nvim-treesitter",
 --    },
 --    event = {"CmdlineEnter"},
 --    ft = {"go", "gomod"},
 --    build = ':lua require("go.install").update_all_sync()',
 --    init = function()
	-- 	  vim.api.nvim_create_autocmd("BufWritePre", {
	-- 		  pattern = { "*.go" },
	-- 		  group = vim.api.nvim_create_augroup("OrganizeImports", {}),
	-- 		  callback = function()
	-- 			  vim.cmd("GoImport")
	-- 	    end,
	-- 	})
	-- end,
 --    opts = function()
 --      require "custom.configs.go"
 --    end,
 --    config = function(opts)
 --      require("go").setup(opts)
 --    end,
 --  },
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
  -- },

}

return plugins
