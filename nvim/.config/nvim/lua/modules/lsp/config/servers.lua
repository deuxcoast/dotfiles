local lspconfig = require("lspconfig")

local servers = {
  bashls = true,
  lua_ls = {
    settings = {
      server_capabilities = {},
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        codeLens = {
          enable = true,
        },
        completion = {
          callSnippet = "Replace",
        },
        doc = {
          privateName = { "^_" },
        },
        hint = {
          enable = true,
          setType = false,
          paramType = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
        },
      },
    },
  },
  html = true,
  pyright = true,
  vimls = true,
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = "",
        },
        -- schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
  -- Enable jsonls with json schemas
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  -- cmake = (1 == vim.fn.executable("cmake-language-server")),
  clangd = {
    -- additional config in ~/Library/Preferences/clangd/config.yaml
    -- This is where clangd looks for additional flags to be added
    -- Currently setup for maximum diagnostics
    cmd = {
      "clangd",
      "--enable-config",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--offset-encoding=utf-16", --temporary fix for null-ls
    },
    init_options = {
      clangdFileStatus = true,
    },
    filetypes = {
      "h",
      "c",
      "cpp",
      "cc",
      "objc",
      "objcpp",
    },
    single_file_support = true,
    root_dir = lspconfig.util.root_pattern(
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac",
      ".git"
    ),
  },

  svelte = true,

  gopls = {
    settings = {
      gopls = {
        codelenses = {
          test = true,
        },
        -- hints = inlays and {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },

    flags = {
      debounce_text_changes = 200,
    },
  },

  cssls = true,

  tailwindcss = {
    filetypes = { "css", "typescript" },
  },
  tsserver = {
    server_capabilities = {
      documentFormattingProvider = false,
    },
  },
}

return servers
