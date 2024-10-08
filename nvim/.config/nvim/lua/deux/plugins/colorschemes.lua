local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

return {
  {
    "catppuccin/nvim",
    cond = has_ui,
    name = "catppuccin",
    -- priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavor = "mocha",
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
          },
        },
        highlight_overrides = {
          mocha = function(mocha)
            return {
              AlphaHeader = { fg = mocha.green },
              AlphaFooter = { fg = mocha.yellow },
              GitSignsAdd = { fg = mocha.teal },
              GitSignsDelete = { fg = mocha.red },
              GitSignsChange = { fg = mocha.yellow },
              WinSeparator = { fg = mocha.rosewater },
              DiffAdd = { fg = mocha.mantle, bg = mocha.teal },
              DiffDelete = { fg = mocha.mantle, bg = mocha.red },
              DiffChange = { fg = mocha.mantle, bg = mocha.yellow },
              DiffText = { fg = mocha.mantle, bg = mocha.pink },
              DapStopped = { fg = mocha.blue, bg = mocha.mantle },
              -- IblScope = { fg = mocha.lavender },
            }
          end,
        },
        no_italic = true,
        no_bold = true,
        integrations = {
          alpha = true,
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          harpoon = true,
          hop = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
          },
          mason = true,
          notify = true,
          noice = true,
          dap = true,
          dap_ui = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            -- underlines = {
            -- 	errors = { "underline" },
            -- 	hints = { "underline" },
            -- 	warnings = { "underline" },
            -- 	information = { "underline" },
            -- },
            inlay_hints = {
              background = true,
            },
          },
          rainbow_delimiters = true,
          telescope = {
            enable = false,
          },
          lsp_trouble = true,
        },
      })
    end,
  },

  {
    "nyoom-engineering/oxocarbon.nvim",
    cond = has_ui,
    init = function()
      vim.cmd.highlight({ "def link @function @function.builtin", bang = true })
    end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    cond = has_ui,
    -- priority = 1000,
    config = function()
      require("rose-pine").setup({
        --- @usage 'auto'|'main'|'moon'|'dawn'
        variant = "auto",
        --- @usage 'main'|'moon'|'dawn'
        dark_variant = "main",
        bold_vert_split = false,
        dim_nc_background = false,
        disable_background = false,
        disable_float_background = false,
        disable_italics = true,
        --- @usage string hex value or named color from rosepinetheme.com/palette
        groups = {
          background = "base",
          background_nc = "_experimental_nc",
          panel = "surface",
          panel_nc = "base",
          border = "highlight_med",
          comment = "muted",
          link = "iris",
          punctuation = "subtle",

          error = "love",
          hint = "iris",
          info = "foam",
          warn = "gold",

          headings = {
            h1 = "iris",
            h2 = "foam",
            h3 = "rose",
            h4 = "gold",
            h5 = "pine",
            h6 = "foam",
          },
          -- or set all headings at once
          -- headings = 'subtle'
        },

        -- Change specific vim highlight groups
        -- https://github.com/rose-pine/neovim/wiki/Recipes
        highlight_groups = {
          -- ColorColumn = { bg = "rose" },

          -- Blend colours against the "base" background
          CursorLine = { bg = "foam", blend = 10 },
          StatusLine = { fg = "love", bg = "love", blend = 10 },

          -- By default each group adds to the existing config.
          -- If you only want to set what is written in this config exactly,
          -- you can set the inherit option:
          Search = { bg = "gold", inherit = false },
        },
      })
    end,
  },

  {
    "sainnhe/gruvbox-material",
    cond = has_ui,
    -- lazy = false,
    -- priority = 1000,
  },

  {
    "rebelot/kanagawa.nvim",
    cond = has_ui,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        background = {
          dark = "dragon",
          light = "lotus"
        }
      })
    end,
  },

  {
    "miikanissi/modus-themes.nvim",
    config = function()
      ---@diagnostic disable-next-line missing-fields
      require("modus-themes").setup({
        on_highlights = function(highlight, color)
          highlight.GitSignsAdd = { fg = color.green, bg = color.bg_main }
          highlight.GitSignsChange = { fg = color.pink, bg = color.bg_main }
          highlight.GitSignsDelete = { fg = color.red, bg = color.bg_main }
          highlight.LineNr = { fg = color.magenta, bg = color.bg_main }
          highlight.LineNrAbove = { fg = color.fg_dim, bg = color.bg_main }
          highlight.LineNrBelow = { fg = color.fg_dim, bg = color.bg_main }
          -- highlight.CursorLineNr = { fg = color.magenta, bg = color.bg_main }
        end
      })
    end
  },

  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
    -- init = function()
    --   vim.cmd.colorscheme("oldworld")
    -- end
  },

  {
    'Yazeed1s/oh-lucy.nvim',
    dev = true,
  },

}
