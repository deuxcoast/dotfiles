local icons = require("deux.icons")
local deux_string = require("deux.utils.string")


local M = {}

M.setup_notify = function()
  local notify = require("notify")
  notify.setup({
    max_height = 8,
    max_width = 100,
    minimum_width = 50,
    timeout = 2500,
    stages = "static",
    icons = {
      DEBUG = icons.Debug,
      ERROR = icons.Error,
      INFO = icons.Info,
      TRACE = icons.Trace,
      WARN = icons.Warn,
    },
  })

  -- =====================================================================
  -- Clear notifications on <Esc><Esc>
  -- =====================================================================

  vim.api.nvim_create_autocmd("User", {
    pattern = "EscEscEnd",
    desc = "Dismiss notifications on <Esc><Esc>",
    callback = function()
      notify.dismiss({ silent = true, pending = true })
    end,
    group = vim.api.nvim_create_augroup("deuxnvimnotify", {}),
  })
end

M.setup_fidget = function()
  local fidget = require("fidget")
  local notify = require("notify")
  fidget.setup()

  -- =====================================================================
  -- Override vim.notify builtin
  -- =====================================================================

  ---@param msg string
  ---@param level? number vim.log.levels.*
  ---@param opts? table
  local override = function(msg, level, opts)
    if not opts then
      opts = {}
    end

    -- known special titles
    -- mason ones should not go to fidget because mason window will cover it
    -- - "mason.nvim"
    -- - "mason-lspconfig.nvim"
    -- - "nvim-treesitter"

    if opts.title == "nvim-treesitter" then
      return fidget.notify(msg, level, opts)
    end

    if not opts.title then
      if deux_string.starts_with(msg, "[LSP]") then
        opts.render = "wrapped-compact"
        local client, found_client = msg:gsub("^%[LSP%]%[(.-)%] .*", "%1")
        if found_client > 0 then
          opts.title = ("[LSP] %s"):format(client)
        else
          opts.title = "[LSP]"
        end
        msg = msg:gsub("^%[.*%] (.*)", "%1")
      elseif msg == "No code actions available" then
        -- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/buf.lua#LL629C39-L629C39
        opts.title = "[LSP]"
      end
    end

    if opts.title and deux_string.starts_with(opts.title, "[LSP]") then
      opts.render = "wrapped-compact"
    end

    return notify(msg, level, opts)
  end
  vim.notify = override

  -- =====================================================================
  -- Clear notifications on <Esc><Esc>
  -- =====================================================================

  vim.api.nvim_create_autocmd("User", {
    pattern = "EscEscEnd",
    desc = "Dismiss notifications on <Esc><Esc>",
    callback = function()
      fidget.notification.clear()
    end,
    group = vim.api.nvim_create_augroup("deuxfidget", {}),
  })
end

M.setup_notify()
M.setup_fidget()

return M
