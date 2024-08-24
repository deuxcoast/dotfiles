local deux_object = require("deux.utils.object")

local settings = {
  border = "rounded",
  diagnostics = {
    goto_float = true,
  },
  heirline = {},
}

local M = {}

M.watchers = {}

M.get = function(path)
  return deux_object.get(settings, path)
end

M.set = function(path, value)
  local current = M.get(value)
  local success = deux_object.set(settings, path, value)

  if success and value ~= current then
    M.watchers[path] = M.watchers[path] or {}
    vim.iter(M.watchers[path]):each(function(cb)
      cb({
        path = path,
        prev = current,
        value = value,
      })
    end)
  end
end

return M
