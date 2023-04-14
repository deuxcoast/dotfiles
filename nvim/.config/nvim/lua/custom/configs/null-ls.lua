local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local goimports = b.formatting.goimports
local e = os.getenv "GOIMPORTS LOCAL"
if e ~= nil then
  goimports = goimports.with { extra_args = { "-local", e } }
end

local sources = {

  -- Code Actions
  b.code_actions.gomodifytags,
  b.code_actions.gitsigns,
  b.code_actions.gitrebase,

  -- Diagnostics
  b.diagnostics.revive,
  b.diagnostics.tsc,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- Formatting
  goimports,
  -- b.formatting.golines.with({
  --   extra_args = {
  --     "--max-len=180",
  --     "--base-formatter=gofumpt",
  --   },
  -- }),

  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.fixjson,
  b.formatting.shfmt,
}

-- for go.nvim
-- local gotest = require("go.null_ls").gotest()
-- local gotest_codeaction = require("go.null_ls").gotest_action()
-- local golangci_lint = require("go.null_ls").golangci_lint()
-- table.insert(sources, gotest)
-- table.insert(sources, golangci_lint)
-- table.insert(sources, gotest_codeaction)

local options = {
  debug = false,
  sources = sources,
}

return options
