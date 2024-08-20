local telescope = require("telescope")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values

local config_path = vim.env.HOME .. "/.config/nvim"

local nvim_list = function()
  local dirs = vim.split(config_path, ",")
  local list = {}
  for _, dir in pairs(dirs) do
    local p = io.popen("rg --files --hidden " .. dir)
    if p then
      for file in p:lines() do
        table.insert(list, file)
      end
    end
  end
  return list
end

local nvim_config = function(opts)
  opts = opts or {}
  local results = nvim_list()

  local custom_entry_maker = function(entry)
    local display = entry:gsub(vim.pesc(config_path .. "/"), "")
    return {
      value = entry,
      display = display,
      ordinal = entry,
    }
  end

  pickers
      .new(opts, {
        prompt_title = "find in nvim config",
        results_title = "nvim config",
        finder = finders.new_table({
          results = results,
          entry_maker = custom_entry_maker,
        }),
        previewer = conf.file_previewer(opts),
        sorter = conf.file_sorter(opts),
      })
      :find()
end

return telescope.register_extension({ exports = { nvim_config = nvim_config } })
