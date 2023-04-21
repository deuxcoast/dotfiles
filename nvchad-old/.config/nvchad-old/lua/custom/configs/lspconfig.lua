local on_attach = require("custom.configs.lsp.utils").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "dockerls", "sqlls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- GOPLS LSP Setup
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      buildFlags = { "-tags=wireinject" },
    },
  },
}


-- YAML LSP Setup
lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/kustomization.json"] = "kustomize.yaml",
      },
    },
  },
}

-- 
-- lspconfig.pyright.setup { blabla}
