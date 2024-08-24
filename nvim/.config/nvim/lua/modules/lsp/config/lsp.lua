local setup = function()
  ---------------------
  -- Capabilities
  ---------------------
  local capabilities = nil
  if pcall(require, "cmp_nvim_lsp") then
    capabilities = require("cmp_nvim_lsp").default_capabilities()
  end

  local lspconfig = require("lspconfig")


  --------------------------
  -- Define Diagnostic Signs
  --------------------------

  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  -- Defining signs
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
  ---------------------
  -- Install servers
  ---------------------

  local servers = require("modules.lsp.config.servers")

  -- use mason to install lsp servers that do not require manual installation
  local servers_to_install = vim.tbl_filter(function(key)
    local t = servers[key]
    if type(t) == "table" then
      return not t.manual_install
    else
      return true
    end
  end, vim.tbl_keys(servers))

  require("mason").setup({})
  local ensure_installed = {}

  vim.list_extend(ensure_installed, servers_to_install)
  require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

  for name, config in pairs(servers) do
    if config == true then
      config = {}
    end
    config = vim.tbl_deep_extend("force", {}, {
      capabilities = capabilities,
    }, config)

    lspconfig[name].setup(config)
  end

  local disable_semantic_tokens = {
    lua = true,
  }

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

      local settings = servers[client.name]
      if type(settings) ~= table then
        settings = {}
      end

      local map = DV.map()
      local builtin = require("telescope.builtin")

      map.n({
        ["gd"] = builtin.lsp_definitions,
        ["gr"] = builtin.lsp_references,
        ["gD"] = vim.lsp.buf.declaration,
        ["gT"] = vim.lsp.buf.type_definition,
        ["gI"] = vim.lsp.buf.implementation,
        ["K"] = vim.lsp.buf.hover,
        ["<leader>cr"] = vim.lsp.buf.rename,
        ["<leader>ca"] = vim.lsp.buf.code_action,
      }, { buf = 0 })

      local filetype = vim.bo[bufnr].filetype
      if disable_semantic_tokens[filetype] then
        ---@diagnostic disable-next-line: inject-field
        client.server_capabilities.semanticTokenProvider = nil
      end

      -- Override server capabilities
      if settings.server_capabilities then
        for k, v in pairs(settings.server_capabilities) do
          if v == vim.NIL then
            ---@diagnostic disable-next-line: cast-local-type
            v = nil
          end

          client.server_capabilities[k] = v
        end
      end
    end,
  })
end

return setup
