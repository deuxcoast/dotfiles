local M = {}

local deux_settings = require 'deux.settings'
local map = require 'deux.utils.keymap'

M.setup = function()
  require('cybu').setup {
    display_time = '1800',
    position = {
      anochor = 'centerright',
      max_win_height = 8,
      max_win_width = 0.5,
    },
    style = {
      border = deux_settings.get 'border',
      hide_buffer_id = true,
      highlights = {
        background = 'CybuAdjacent',
        current_buffer = 'TelescopeSelection',
        adjacent_buffers = 'Normal',
      },
    },
    exclude = {
      'qf',
      'help',
    },
  }

  map.n {
    ['<C-p>'] = '<Plug>(CybuPrev)',
    ['<C-n>'] = '<Plug>(CybuNext)',
  }
end

M.setup()

return M
