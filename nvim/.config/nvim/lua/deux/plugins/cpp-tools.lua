local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

return {
  'Badhi/nvim-treesitter-cpp-tools',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  cond = has_ui,
  ft = 'cpp',
  config = function()
    require('deux.config.cpp_tools').setup()
  end,
}
