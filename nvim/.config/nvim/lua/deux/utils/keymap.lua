local set_keymap = vim.api.nvim_set_keymap
local buf_set_keymap = vim.api.nvim_buf_set_keymap

-- Use space as leader key
vim.g.mapleader = " "

-- Cache for storing buffer-specific key mapping functions.
local buf_map_cache = {}

-- Function to get or create a buffer-specific key mapping function.
-- @param buf number: Buffer ID for which the key mappings are to be set.
-- @return function: A function that sets key mappings for the specified buffer.
local function buf_map(buf)
  local fn = buf_map_cache[buf]
  if not fn then
    function fn(mode, lhs, rhs, opts)
      buf_set_keymap(buf, mode, lhs, rhs, opts)
    end

    buf_map_cache[buf] = fn
  end
  return fn
end

-- Function to remove specific keys from a table.
-- @param tbl table: The table from which to remove keys.
-- @param keys table: The list of keys to remove.
local function key_nil(tbl, keys)
  for _, key in pairs(keys) do
    tbl[key] = nil
  end
end

-- Function to resolve and validate mode strings for key mappings.
-- @param key string: The mode string to resolve.
-- @return table: A table of resolved modes.
local function resolve_mode(key)
  if #key == 0 then
    return { "" } -- Empty string means all modes (default mapping).
  end

  local modes = {}
  for char in key:gmatch(".") do
    if not char:find("[!abcilnostvx]") then
      error(('invalid mode "%s"'):format(char))
    end
    modes[char] = true
  end

  -- alias a -> :map and b -> :map!
  if modes.a then
    modes.a = nil
    modes[""] = true
  end
  if modes.b then
    modes.b = nil
    modes["!"] = true
  end

  -- convert xs -> :vmap, nvo -> :map, ic -> :map!
  if modes.x and modes.s then
    modes.v = true
  end
  if modes.n and modes.v and modes.o then
    modes[""] = true
  end
  if modes.i and modes.c then
    modes["!"] = true
  end

  -- remove redundant modes for :map and :vmap
  local keys = {}
  if modes[""] then
    vim.list_extend(keys, { "n", "v", "o", "x", "s" })
  elseif modes.v then
    vim.list_extend(keys, { "x", "s" })
    -- remove redundant modes for :lmap and :map!
  elseif modes.l then
    vim.list_extend(keys, { "!", "i", "c" })
  elseif modes["!"] then
    vim.list_extend(keys, { "i", "c" })
  end

  key_nil(modes, keys)
  return modes
end

-- Function to merge two tables.
-- @param t table: The base table.
-- @param n table: The table to merge into the base table.
-- @return table: The merged table.
local function merge(t, n)
  if n then
    for k, v in pairs(n) do
      t[k] = v
    end
  end
  return t
end

-- Index function for the metatable to dynamically handle key mappings.
-- @param self table: The map table.
-- @param key string: The key representing the mode or special command.
-- @return function: A function to set key mappings for the given mode or command.
local function index(self, key)
  assert(type(key) == "string", "invalid key")

  -- Special case for handling the 'cmd' key, which returns a function for command mappings.
  if key == "cmd" then
    local cmd_fn = function(str)
      return "<Cmd>" .. str .. "<CR>"
    end
    rawset(self, key, cmd_fn)
    return cmd_fn
  end

  -- Resolve the mode string to a table of modes.
  local modes = resolve_mode(key)

  -- Function to set key mappings based on the arguments provided.
  -- @param arg1 string|table: The left-hand side key or a table of mappings.
  -- @param arg2 string|function: The right-hand side command or function (optional if arg1 is a table).
  -- @param arg3 table: Optional settings for the key mapping (optional if arg1 is a table).
  -- @return nil
  local function map_fn(arg1, arg2, arg3)
    local opts, maps

    if type(arg1) == "string" and (type(arg2) == "string" or type(arg2) == "function") then
      opts = arg3
      assert(opts == nil or type(opts) == "table", "expected table as argument #3")
    elseif type(arg1) == "table" then
      opts, maps = arg2, arg1
      assert(opts == nil or type(opts) == "table", "expected table as argument #2")
    else
      error("expected (string, string|function, table?) or (table, table?)")
    end

    -- Merge the provided options with the default options.
    do
      local opts_copy = {}
      merge(opts_copy, rawget(self, "opts"))
      merge(opts_copy, opts)
      opts = opts_copy
    end

    -- Adjust key mapping options based on the presence of 'remap' or 'noremap'.
    -- mappings are non-recursive by default
    if opts.remap then
      opts.remap = nil
      opts.noremap = false
    elseif opts.noremap == nil then
      opts.noremap = true
    end

    local replace_keycodes = opts.replace_keycodes

    -- Determine if the mapping is global or buffer-specific.
    local map
    if not opts.buf then
      map = set_keymap
    else
      map = buf_map(opts.buf)
      opts.buf = nil
    end

    -- Handle single and batch mappings.
    if not maps then
      if type(arg2) == "function" then
        opts.callback = arg2
        arg2 = ""
        if opts.expr and replace_keycodes == nil then
          opts.replace_keycodes = true
        end
      else
        opts.callback = nil
      end

      for mode in pairs(modes) do
        map(mode, arg1, arg2, opts)
      end
    else
      for lhs, rhs in pairs(maps) do
        if type(rhs) == "function" then
          opts.callback = rhs
          rhs = ""
          if opts.expr and replace_keycodes == nil then
            opts.replace_keycodes = true
          end
        elseif type(rhs) == "string" then
          opts.callback = nil
          if opts.expr and replace_keycodes == nil then
            opts.replace_keycodes = false
          end
        else
          error("expected string or function as rhs")
        end

        for mode in pairs(modes) do
          -- print(vim.inspect(opts))
          map(mode, lhs, rhs, opts)
        end
      end
    end
  end

  rawset(self, key, map_fn)
  return map_fn
end

-- Metatable for the map table to handle dynamic mode-based key mapping.
---@class keymap
local mt = { __index = index }

-- Constructor function to create a new map table with optional default options.
-- @param opts table: Optional default options for key mappings.
-- @return table: The map table with the provided options and a metatable.
local function new(opts)
  assert(opts == nil or type(opts) == "table", "expected table")
  return setmetatable({
    opts = opts,
    new = new,
  }, mt)
end

---# Keymap definitions
---
------
---*Examples:*
---- Basic normal mode mapping
---```lua
---  map.n('a', ':a<CR>')
---```
---- Multiple modes: normal and visual mode
---```lua
---  map.nx('b', ':b<CR>')
---```
---- `a` is `:map`, `b` is `:map!`
---```lua
---  map.a('c', ':c<CR>')
---  map.b('d', ':d<CR>')
---```
---- Attributes
---```lua
---  map.n('e', ':e<CR>', { buf=0, remap=true })
---```
---- Lua function
---```lua
---  map.n('f', function() print('f') end)
---```
---- Batch
---```lua
---  map.n({ g = ':g<CR>', h = ':h<CR>' }, { expr=true })
---```
---
------
---*Map table:*
--- KEY      | a n b i c v x s o t l
-------------|-----------------------
--- Normal   | ✓ ✓
--- Insert   |     ✓ ✓             ✓
--- Command  |     ✓   ✓
--- Visual   | ✓         ✓ ✓
--- Select   | ✓         ✓   ✓
--- Operator |                 ✓
--- Terminal |                   ✓
--- Lang-Arg |                     ✓
local map = new({ silent = true })

return map
