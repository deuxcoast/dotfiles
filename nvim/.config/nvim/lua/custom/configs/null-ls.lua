local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins
local nls_utils = require "null-ls.utils"

local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]",
  }
end

local with_root_file = function(builtin, file)
  return builtin.with {
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  }
end

local sources = {

  -- Code Actions
  b.code_actions.gomodifytags,
  b.code_actions.gitsigns,
  b.code_actions.gitrebase,

  -- Diagnostics
  b.diagnostics.tsc,
  with_root_file(b.diagnostics.selene, "selene.toml"),
  with_diagnostics_code(b.diagnostics.shellcheck),


  -- Formatting
  -- b.formatting.goimports,
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.fixjson,
  with_root_file(b.formatting.stylua, "stylua.toml"),
}

null_ls.setup {
  debug = true,
  debounce = 150,
  save_after_format = false,
  -- on_attach = opts.on_attach,
  sources = sources,
  -- root_dir = nls_utils.root_pattern ".git",
}
