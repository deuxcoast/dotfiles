local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

return {


  --------------------------------------------------------------------------------------------------
  -- -LspConfig
  --------------------------------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "b0o/schemastore.nvim",
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      "stevearc/conform.nvim",
      "folke/lazydev.nvim",
    },
    config = function()
      require("deux.config.lsp").setup()
    end
  },

  --------------------------------------------------------------------------------------------------
  -- Conform
  --------------------------------------------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    event = "BufEnter",
    cmd = { "ConformInfo" },
    config = function()
      require("deux.config.conform").setup()
    end,
  },

  ----------------------------------------------------------------------------------------------------
  -- LazyDev
  ----------------------------------------------------------------------------------------------------
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "luvit-meta/library",
      },
    },
  },

  {
    "Bilal2453/luvit-meta",
    lazy = true
  },

  { -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },

  ----------------------------------------------------------------------------------------------------
  -- Mason
  ----------------------------------------------------------------------------------------------------

  {
    "williamboman/mason.nvim",
    event = "User FilePost",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonInstallAll",
      "MasonUpdate",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
  },

  { "WhoIsSethDaniel/mason-tool-installer.nvim" },


  --------------------------------------
  --     {
  --       "hsaker312/diagnostics-details.nvim",
  --       cmd = "DiagnosticsDetailsOpenFloat",
  --       config = function()
  --         require("diagnostics-details").setup({
  --           -- Your configuration here
  --         })
  --       end,
  --     },
  -- {
  --   "aznhe21/actions-preview.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     "creativenull/efmls-configs-nvim",
  --   },
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     -- border on :LspInfo window
  --     require("lspconfig.ui.windows").default_options.border =
  --         require("deux.settings").get("border")
  --   end,
  -- },
  -- {
  --   "hrsh7th/cmp-nvim-lsp", -- provides some capabilities
  --   config = function()
  --     local cnl = require("cmp_nvim_lsp")
  --     cnl.setup()
  --     deux_lsp.base_config.capabilities = vim.tbl_deep_extend(
  --       "force",
  --       deux_lsp.base_config.capabilities,
  --       cnl.default_capabilities()
  --     )
  --   end,
  -- },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",  -- provides some capabilities
  --     "neovim/nvim-lspconfig", -- wait for lspconfig
  --
  --     -- @TODO move these somewhere else
  --     "b0o/schemastore.nvim",                  -- wait for schemastore for jsonls
  --     "davidosomething/format-ts-errors.nvim", -- extracted ts error formatter
  --     "marilari88/twoslash-queries.nvim",      -- tsserver comment with  ^? comment
  --   },
  --   config = function()
  --     local lspconfig = require("lspconfig")
  --
  --     deux_tools.setup_unmanaged_lsps(deux_lsp.middleware)
  --
  --     -- Note that instead of on_attach for each server setup,
  --     -- behaviors.lua has an autocmd LspAttach defined
  --     local handlers = deux_tools.get_mason_lspconfig_handlers(deux_lsp.middleware)
  --
  --     handlers[1] = function(server)
  --       lspconfig[server].setup(deux_lsp.middleware())
  --     end
  --
  --     local lsps = deux_tools.get_mason_lsps()
  --     require("mason-lspconfig").setup({
  --       automatic_installation = has_ui,
  --       ensure_installed = lsps,
  --       handlers = handlers,
  --     })
  --   end,
  -- },
}
