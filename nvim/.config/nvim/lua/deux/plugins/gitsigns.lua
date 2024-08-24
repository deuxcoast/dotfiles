local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

return {
  "lewis6991/gitsigns.nvim",
  cond = has_ui,
  event = "VimEnter",
  config = function()
    require("deux.config.gitsigns").setup()
  end,
}
