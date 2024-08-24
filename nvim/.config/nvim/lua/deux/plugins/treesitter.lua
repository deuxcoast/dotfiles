local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

return {
  "nvim-treesitter/nvim-treesitter",
  cond = has_ui,
  event = "BufRead",
  run = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "RRethy/nvim-treesitter-endwise",
    "kana/vim-textobj-user",
    "kana/vim-textobj-line",
    "kana/vim-textobj-entire",
  },
  config = function()
    require("deux.config.treesitter")
  end
}
