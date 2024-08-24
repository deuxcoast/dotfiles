local M = {}

M.base_config = {
  capabilities = vim.lsp.protocol.make_client_capabilities()
}

M.middleware = function(config)
  config = config or {}
  return vim.tbl_deep_extend("force", M.base_config, config)
end
