local toast = require("deux.utils.notify").toast

local lsp = vim.lsp
local handlers = lsp.handlers
local Methods = lsp.protocol.Methods

local config = {
  border = require("deux.settings").get("border"),
  silent = true,
}

handlers[Methods.textDocument_hover] = lsp.with(handlers.hover, config)

handlers[Methods.textDocument_signatureHelp] =
    lsp.with(handlers.signature_help, config)

-- Convert an LSP MessageType to a vim.notify vim.log.levels int
local function lsp_messagetype_to_vim_log_level(mt)
  local lvl = ({ "ERROR", "WARN", "INFO", "DEBUG" })[mt]
  return vim.log.levels[lvl]
end

---Show LSP messages via toast (default is vim.notify or nvim_out_write)
handlers[Methods.window_showMessage] = function(_, result, ctx, _)
  local client = lsp.get_client_by_id(ctx.client_id)
  local client_name = client and client.name or ctx.client_id
  local title = ("[LSP] %s"):format(client_name)
  if not client then
    toast(result.message, vim.log.levels.ERROR, { title = title })
  else
    local level = lsp_messagetype_to_vim_log_level(result.type)
    toast(result.message, level, { title = title })
  end
  return result
end
