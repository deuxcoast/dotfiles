return {
  init = function(self)
    self.normal = require("util.buffers").get_normal()

    self.modified = vim.tbl_filter(function(bufnr)
      return vim.bo[bufnr].modified
    end, self.normal)
  end,
  hl = function()
    return "StatusLineNC"
  end,
  {
    provider = function(self)
      return (" 󰤌 %d"):format(#self.modified)
    end,
    hl = function(self)
      return #self.modified > 0 and "WarningMsg" or "StatusLineNC"
    end,
  },
  {
    provider = function(self)
      return ("/%d "):format(#self.normal)
    end,
  },
}
