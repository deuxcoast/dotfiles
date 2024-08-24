local heirline = require("heirline.utils")
local get_hl = heirline.get_highlight

local M = {}

local colors = {
  bg_normal = "#1B1D26",
  black = "#1B1D26",
  green = "#76C5A4",
  lavender = "#BDA9D4",
  purple = "#AF98E6",
  grey0 = "#5E6173",
  grey1 = "#AEAFAD",
  grey2 = "#D7D7D7",
  red0 = "#D95555",
  red1 = "#E0828D",
  red2 = "#FB7DA7",
  yellow = "#E3CF65",
  orange = "#E39A65",
  pink = "#BDA9D4",
  blue0 = "#8DBBD3",
  blue1 = "#6CAEC0",
}


local hl = {

  StatusLine = get_hl("Normal"),

  ReadOnly = { fg = get_hl("DiagnosticFloatingError").fg },

  -- WorkDir = { fg = get_highlight('Comment').fg },
  WorkDir = { fg = colors.grey1 },

  CurrentPath = { fg = colors.lavender },

  FileName = { fg = colors.green },

  DapMessages = { fg = colors.lavender },

  Git = {
    branch = { fg = colors.purple },
    added = { fg = colors.green },
    changed = { fg = colors.yellow },
    removed = { fg = colors.red },
    dirty = { fg = colors.pink },
  },

  LspIndicator = { fg = colors.blue0 },

  LspServer = { fg = colors.red2 },

  Diagnostic = {
    error = { fg = colors.red0 },
    warn = { fg = colors.yellow },
    info = { fg = colors.orange },
    hint = { fg = colors.pink },
  },

  ScrollBar = { bg = colors.grey0, fg = colors.grey1 },

  SearchResults = { fg = colors.black, bg = colors.purple },

  WinBar = { fg = get_hl("StatusLine").fg, bg = get_hl("SignColumn").bg },

  Navic = {
    Separator = { fg = colors.blue0 },
  },
}

M.highlight = hl

-- Mode colors
do
  local mode_colors = {
    normal       = colors.grey2,
    op           = colors.green,
    insert       = colors.green,
    visual       = colors.yellow,
    visual_lines = colors.yellow,
    visual_block = colors.yellow,
    replace      = colors.red0,
    v_replace    = colors.red0,
    enter        = colors.blue0,
    more         = colors.blue0,
    select       = colors.purple,
    command      = colors.orange,
    shell        = colors.pink,
    term         = colors.pink,
    none         = colors.red,
  }

  hl.Mode = setmetatable({
    normal = { fg = mode_colors.normal }
  }, {
    __index = function(_, mode)
      return {
        -- fg = colors.black,
        fg = colors.bg_normal,
        bg = mode_colors[mode],
        bold = true
      }
    end
  })
end

-- hydra
do
  -- #008080
  -- #00a4a4
  -- #00aeae

  -- #f2594b
  -- #f36c62

  -- #ff1757
  -- #ff476b
  -- #ff5170

  -- #f063b2
  -- #f173b7

  M.hydra = {
    red = '#f36c62',
    amaranth = '#ff5170',
    teal = '#00aeae',
    pink = '#f173b7'
  }
end

M.lsp_colors = {
  gopls     = '#08A6D0',
  lua_ls    = '#5EBCF6',
  vimls     = '#43BF6C',
  ansiblels = '#ffffff',
  tsserver  = '#F0D951',
  clangd    = '#699DD3',
  bash      = '#43BF6C',
  python    = '#FFD44A',

}

return M
