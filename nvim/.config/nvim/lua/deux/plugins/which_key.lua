local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

return {
  'folke/which-key.nvim',
  cond = has_ui,
  event = 'VeryLazy',
  opts = {},
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
