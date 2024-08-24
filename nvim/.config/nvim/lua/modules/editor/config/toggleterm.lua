local setup = function()
  require("toggleterm").setup({
    highlights = {
      Normal = { link = "Normal" },
      NormalFloat = { link = "Normal" }, -- also using NormalFloat here makes the border weird
      StatusLine = { link = "StatusLine" },
      StatusLineNC = { link = "StatusLineNC" },
    },
    size = function(term)
      if term.direction == "horizontal" then
        return 21
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = "<C-t>",
    terminal_mappings = true,
    hide_numbers = true,      -- hide the number column in toggleterm buffers
    shade_terminals = false,
    shading_factor = 1,       -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true,   -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = "horizontal", -- | 'vertical' | 'tab' | 'float',
    close_on_exit = true,     -- close the terminal window when the process exits
    shell = vim.o.shell,      -- change the default shell
    float_opts = {
      border = "curved",      --'single' | 'double' | 'shadow' | 'curved',
      winblend = 0,
    },
  })
end

return setup
