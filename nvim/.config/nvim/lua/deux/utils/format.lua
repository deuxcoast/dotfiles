local Methods = vim.lsp.protocol.Methods

---@param names string[]
local function notify(names)
  if #names == 0 then
    return
  end
  vim.notify("format", vim.log.levels.INFO, {
    render = "wrapped-compact",
    title = ("[LSP] %s"):format(table.concat(names, ", ")),
  })
end

local M = {}


-- =============================================================================
-- Autocmd handlers
-- =============================================================================

M.enable_on_lspattach = function(args)
  local bufnr = args.buf
  local clients = vim.lsp.get_clients({
    id = args.data.client_id,
    bufnr = bufnr,
    method = Methods.textDocument_formatting,
  })
  if #clients == 0 then -- just to shut up type checking
    return
  end

  vim.b.enable_format_on_save = true

  -- Track formatters, non-exclusively, non-LSPs might add to this table
  -- or fire the autocmd
  local name = clients[1].name

  -- You cannot table.insert(vim.b.formatters, name) -- need to have a
  -- temp var and assign full table at once because the vim.b vars are special
  local formatters = vim.b.formatters
  if formatters == nil then
    formatters = { name }
  else
    table.insert(formatters, name)
  end
  vim.b.formatters = formatters

  vim.cmd.doautocmd("User", "FormatterAdded")
end

-- LspDetach autocmd callback
M.disable_on_lspdetach = function(args)
  -- was already disabled manually?
  if not vim.b.enable_format_on_save then
    return
  end

  local bufnr = args.buf
  local detached_client_id = args.data.client_id

  local capable_clients = vim.lsp.get_clients({
    bufnr = bufnr,
    method = Methods.textDocument_formatting,
  })

  local still_has_formatter = vim.iter(capable_clients):any(function(client)
    return client.id ~= detached_client_id
  end)
  if still_has_formatter then
    return
  end

  vim.b.enable_format_on_save = false
  vim.schedule(function()
    vim.notify(
      "Format on save disabled, no capable clients attached",
      vim.log.levels.INFO,
      { title = "[LSP]", render = "compact" }
    )
  end)
end

-- autocmd callback for *WritePre
M.format_on_save = function()
  -- callback gets arg
  -- {
  --   buf = 1,
  --   event = "BufWritePre",
  --   file = "nvim/lua/dko/behaviors.lua",
  --   id = 127,
  --   match = "/home/davidosomething/.dotfiles/nvim/lua/dko/behaviors.lua"
  -- }
  if not vim.b.enable_format_on_save then
    return
  end
  M.run_pipeline({ async = false })
end
