local prettier = { 'prettierd', 'prettier', stop_after_first = true }
---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require 'conform'
  for i = 1, select('#', ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

local M = {}

M.setup = function()
  require('conform').setup {
    default_format_opts = {
      lsp_format = 'fallback',
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      javascript = prettier,
      typescript = prettier,
      javascriptreact = prettier,
      typescriptreact = prettier,
      css = prettier,
      graphql = prettier,
      html = prettier,
      json = prettier,
      json5 = prettier,
      jsonc = prettier,
      yaml = prettier,
      markdown = function(bufnr)
        return { first(bufnr, 'prettierd', 'prettier'), 'injected' }
      end,
      lua = { 'stylua' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      go = { 'goimports', 'gofmt' },
      python = { 'isort', 'black' },
      sh = { 'shmft' },
    },
    formatters = {
      ['clang-format'] = {
        prepend_args = {
          '--style',
          '{BasedOnStyle: Chromium, IndentWidth: 4, ColumnLimit: 80, AlignTrailingComments: true, BraceWrapping: {AfterFunction: false}}',
        },
      },
    },
  }
end

M.setup()

return M
