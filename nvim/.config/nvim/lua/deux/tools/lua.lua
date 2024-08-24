local tools = require("deux.tools")

-- tools.register({
--   mason_type = "tool",
--   require("_"),
--   name = "stylua",
--   fts = {"lua"},
-- })
--
local M = {}

local nvim_dir = ("%s/nvim"):format(vim.env.XDG_CONFIG_HOME)
local after_dir = ("%s/after"):format(nvim_dir)

tools.register({
  mason_type = "lsp",
  require = "_",
  name = "lua_ls",
  runner = "mason-lspconfig",
  lspconfig = function()
    return {
      settings = {
        Lua = {
          format = { enable = false },
          hint = { enable = true },
          runtime = {
            version = "LuaJIT",
          },
          workspace = {
            maxPreload = 1000,
            preloadFileSize = 500,
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              unpack(M.get_runtime_files()),
              "${3rd}/luv/library"
            }
          }
        }
      }
    }
  end
})
