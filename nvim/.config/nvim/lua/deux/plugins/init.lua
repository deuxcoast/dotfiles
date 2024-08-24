local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

return {

  -- =========================================================================
  -- ui: components
  -- =========================================================================

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    cond = has_ui,
    config = true,
  },

  -- =========================================================================
  -- ui: buffer and window manipulation
  -- =========================================================================

  {
    "alexghergh/nvim-tmux-navigation",
    cond = has_ui,
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
  },
  {
    "yorickpeterse/nvim-window",
    cond = has_ui,
    keys = {
      { "<leader>wj", "<cmd>lua require('nvim-window').pick()<cr>", desc = "nvim-window: Jump to window" },
    },
    config = true,
  }
}
