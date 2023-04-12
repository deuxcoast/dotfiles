local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "dockerls", "sqlls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      linksInHover = false,
      codelenses = {
        generate = true,
        gc_details = true,
        regenerate_cgo = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      usePlaceholders = true,
    },
  },
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

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
