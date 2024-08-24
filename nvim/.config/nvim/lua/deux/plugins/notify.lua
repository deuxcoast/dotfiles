local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

return {
  {
    "j-hui/fidget.nvim",
    cond = has_ui,
    dependencies = { "rcarriga/nvim-notify" },
    config = function()
      require("deux.config.notify").setup_fidget()
    end

  }, {
  "rcarriga/nvim-notify",
  cond = has_ui,
  lazy = false,
  priority = 1000,
  config = function()
    require("deux.config.notify").setup_notify()
  end
},
}
