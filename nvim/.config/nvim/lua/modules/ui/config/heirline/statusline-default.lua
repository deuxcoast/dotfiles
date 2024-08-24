return {
  init = function(self)
    self.branch = require "heirline.conditions".is_git_repo() and vim.g.gitsigns_head or ""

    self.cwd = vim.uv.cwd()
  end,

  require("modules.ui.config.heirline.mode"),

  require("modules.ui.config.heirline.searchterm"),
  require("modules.ui.config.heirline.cwd"),
  require("modules.ui.config.heirline.git"),

  -- this means that the statusline is cut here when there's not enough space
  { provider = "%<" },

  -- spacer with inactive color
  {
    provider = "%=",
    hl = "StatusLineNC",
  },
  -- ruler
  {
    condition = require("heirline.conditions").is_active,
    provider = "%7(%l/%3L%):%2c %P",
    hl = "StatusLine",
  },
}
