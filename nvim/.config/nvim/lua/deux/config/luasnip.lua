local M = {}

M.setup = function()
  local snippets_path = vim.fn.stdpath 'config' .. '/lua_snippets'

  -- TODO: This isn't working - figure out how to get html completions in
  -- htmldjango files
  -- extend html completions into `djangohtml` filetype
  require('luasnip').filetype_extend('djangohtml', { 'html' })

  -- load my lua snippets
  require('luasnip.loaders.from_lua').load { paths = { snippets_path } }

  -- load vscode style snippets
  require('luasnip.loaders.from_vscode').lazy_load()
end

M.setup()

return M
