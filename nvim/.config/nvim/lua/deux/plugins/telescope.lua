local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

return {
  "nvim-telescope/telescope.nvim",
  cond = has_ui,
  event = "VimEnter",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-dap.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "benfowler/telescope-luasnip.nvim",
    "folke/trouble.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    require("deux.config.telescope")
  end
}
