local package = require("util").pack.package
local conf = require("modules.editor.config")

--------------------------------------------------------------------------------
-- Telescope
--------------------------------------------------------------------------------
package({
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  cmd = "Telescope",
  config = conf.telescope,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-dap.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "benfowler/telescope-luasnip.nvim",
    "folke/trouble.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
})

--------------------------------------------------------------------------------
-- Treesitter
--------------------------------------------------------------------------------
package({
  "nvim-treesitter/nvim-treesitter",
  event = "BufRead",
  run = ":TSUpdate",
  config = conf.treesitter,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "RRethy/nvim-treesitter-endwise",
    "kana/vim-textobj-user",
    "kana/vim-textobj-line",
    "kana/vim-textobj-entire",
  },
})

--------------------------------------------------------------------------------
-- Nvim Tmux Navigation
--------------------------------------------------------------------------------
package({
  "alexghergh/nvim-tmux-navigation",
  config = function()
    require("nvim-tmux-navigation").setup({
      disable_when_zoomed = true, -- defaults to false
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
        next = "<C-Space>",
      },
    })
  end,
})

--------------------------------------------------------------------------------
-- Oil
--------------------------------------------------------------------------------
package({
  "stevearc/oil.nvim",
  config = conf.oil,
  dependencies = { "nvim-tree/nvim-web-devicons" },
})

--------------------------------------------------------------------------------
-- Trouble
--------------------------------------------------------------------------------
package({
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {
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
  },
})

--------------------------------------------------------------------------------
-- GitSigns
--------------------------------------------------------------------------------
package({
  "lewis6991/gitsigns.nvim",
  event = "VimEnter",
  config = conf.gitsigns,
})

-- package({
--   "NeogitOrg/neogit",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "sindrets/diffview.nvim",
--     "nvim-telescope/telescope.nvim",
--   },
--   config = true
-- })

--------------------------------------------------------------------------------
-- ToggleTerm
--------------------------------------------------------------------------------
package({
  "akinsho/toggleterm.nvim",
  config = conf.toggleterm,
})
