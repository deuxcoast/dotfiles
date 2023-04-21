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
    "make",
    "markdown",
    "markdown_inline",
    "astro",
    "go",
    "sql",
    "bash",
    -- "gitconfig",
    "gitignore",
    "yaml",
    "toml",
  },
  incremental_selection = {
      enable = true,
      keymaps = {
        -- mappings for incremental selection (visual mappings)
        init_selection = "gnn", -- maps in normal mode to init the node/scope selection
        node_incremental = "grn", -- increment to the upper named parent
        scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
        node_decremental = "grm" -- decrement to the previous node
      }
    },

  textobjects = {
      -- syntax-aware textobjects
      enable = true,
      lsp_interop = {
        enable = true,
        peek_definition_code = {
          ["DF"] = "@function.outer",
          ["DF"] = "@class.outer"
        }
      },
      keymaps = {
        -- ["iL"] = {
        --   -- you can define your own textobjects directly here
        --   go = "(function_definition) @function",
        -- },
        -- or you use the queries from supported languages with textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["ae"] = "@block.outer",
        ["ie"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["is"] = "@statement.inner",
        ["as"] = "@statement.outer",
        ["ad"] = "@comment.outer",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner"
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer"
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer"
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer"
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer"
        },
      },
      select = {
        enable = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          -- Or you can define your own textobjects like this
          -- ["iF"] = {
          --   python = "(function_definition) @function",
          --   cpp = "(function_definition) @function",
          --   c = "(function_definition) @function",
          --   java = "(method_declaration) @function",
          --   go = "(method_declaration) @function"
          -- }
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner"
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner"
        }
      },
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
    "eslint_d",

    -- golang
    "gopls",
    "goimports",
    "gofumpt",
    "gomodifytags",

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
  -- current_line_blame = true,
}

-- M.comment = {
--   pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
-- }

return M
