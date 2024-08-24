local setup = function()
  local utils = require("heirline.utils")
  local theme = require("modules.ui.config.heirline.theme")
  local function setup_colors()
    return theme.highlight
  end

  require("heirline").load_colors(theme.highlight)

  vim.api.nvim_create_augroup("Heirline", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      utils.on_colorscheme(setup_colors)
    end,
    group = "Heirline",
  })

  -- local ALWAYS = 2
  -- vim.o.showtabline = ALWAYS

  local GLOBAL = 3
  vim.o.laststatus = GLOBAL

  require("heirline").setup({
    statusline = require("modules.ui.config.heirline.status").StatusLines,
  })
end
return setup
