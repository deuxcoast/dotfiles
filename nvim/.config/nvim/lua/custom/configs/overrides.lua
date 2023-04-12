local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "json",
    "javascript",
    "typescript",
    "tsx",
    "markdown",
    "markdown_inline",
    "astro",
    "go",
    "sql",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "sqls",

    -- golang
    "gopls",

    -- misc
    "dockerfile-language-server",
    "yaml-language-server",

  },
}

-- git support in nvimtree

M.nvimtree = {
  git = {
    enable = true,
    ignore = false,
  },
  filters = {
    custom = {"^\\.git", ".DS_Store"},
    dotfiles = false,
    exclude = { ".gitignore", "github", "github.com"}
  },
  view = {
    adaptive_size = false,
  },
  renderer = {
    highlight_git = true,
    full_name = true,
    icons = {
      webdev_colors = true,
      show = {
        git = true
      }
    }
  }
}

M.ui = {
  statusline = {
    separator_style = "arrow",
  },

  tabufline = {
    enabled = true,
    lazyload = false,
  },
}

M.gitsigns = {
 signs = {
    add = { hl = "DiffAdd", text = "▎", numhl = "GitSignsAddNr" },
    change = { hl = "DiffChange", text = "▎", numhl = "GitSignsChangeNr" },
    delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
    topdelete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
    changedelete = { hl = "DiffChangeDelete", text = "", numhl = "GitSignsChangeNr" },
    untracked = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
  },
}

return M
