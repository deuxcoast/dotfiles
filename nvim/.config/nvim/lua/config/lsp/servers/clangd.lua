local present, nvim_lsp = pcall(require, "lspconfig")
if not present then
	return
end

local M = {}
M.setup = function(capabilities)
	local config = require("lspconfig.configs")
	capabilities.offsetEncoding = { "utf-16" }
	--[[ if not config.clangd then ]]
	--[[ 	config.clangd = {} ]]
	--[[ end ]]
	nvim_lsp.clangd.setup({ capabilities = capabilities })
end

return M
