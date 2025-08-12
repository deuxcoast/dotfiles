local M = {}

M.setup = function()
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

  ---@diagnostic disable-next-line: missing-fields
  require('nvim-treesitter.configs').setup {

    ensure_installed = {
      'astro',
      'bash',
      'c',
      'cmake',
      'cpp',
      'css',
      'diff',
      'dockerfile',
      'gitignore',
      'go',
      'graphql',
      'html',
      'http',
      'javascript',
      'jsdoc',
      'json',
      'jsonc',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'prisma',
      'python',
      'query',
      'regex',
      'scss',
      'svelte',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'sql',
    },
    highlight = {
      enable = true,
      disable = function(_, buf)
        local max_filesize = 120 * 1024
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    endwise = { enable = true },
    matchup = { enable = true },
    -- indent = { enable = true },
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']f'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']F'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
    },
  }
end

M.setup()

return M
