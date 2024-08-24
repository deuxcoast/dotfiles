return {
  "goolord/alpha-nvim",
  cond = #vim.api.nvim_list_uis() > 0,
  event = "VimEnter",
  config = function()
    require("deux.config.alpha").setup()
  end,
}
