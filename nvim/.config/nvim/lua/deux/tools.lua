local deux_table = require("deux.utils.table")
local M = {}

M.install_groups = { tool = {}, lsp = {} }

local mason_lspconfig_resolvers = {}

local lspconfig_resolvers = {}

M.register = function(config)
  if config.mason_type then
    if config.mason_type ~= "lsp" and config.mason_type ~= "tool" then
      vim.notify(
        ("Invalid mason_type %s for %s"):format(config.mason_type, config.name),
        vim.log.levels.ERROR)
    else
      local req = config.require or "_"
      local group = M.install_groups[config.mason_type]
      group[req] = group[req] or {}
      group[req][config.name] = true
    end
  end

  -- ===========================================================================
  -- Register LSP
  -- ===========================================================================
  local config_map
  if config.runner == "lspconfig" then
    config_map = lspconfig_resolvers
  elseif config.runner == "mason-lspconfig" then
    config_map = mason_lspconfig_resolvers
  end
  if config_map == nil then
    return
  end

  -- make sure mason-lspconfig does not try to automatically set up this lsp
  if config.skip_init ~= nil then
    config_map[config.name] = function()
      return function()
        -- noop
      end
    end
  end

  -- this lsp has a custom setup function
  if config.lsp then
    -- define resolver for a tool
    -- set up the lspconfig with the lspconfig() function from tool registration
    config_map[config.name] = function(middleware)
      -- middleware or nooop middleware
      middleware = middleware
          or function(lspconfig)
            return lspconfig or {}
          end
      -- set up lsp
      return function()
        require("lspconfig")[config.name].setup(middleware(config.lspconfig()))
      end
    end
  end
end

local fegcache = {}

M.filter_executable_groups = function(category, groups)
  if not fegcache[category] then
    fegcache[category] = deux_table.filter(groups, function(_, bin)
      if bin ~= "_" and vim.fn.executable(bin) == 0 then
        require("deux.doctor").warn({
          category = category,
          message = ("[%s] %s not found, skip installation"):format(
            category,
            bin
          ),
        })
        return false
      end
      return true
    end)
  end
  return fegcache[category]
end

M.groups_to_tools = function(groups)
  local result = {}
  for _, items in pairs(groups) do
    for name in pairs(items) do
      table.insert(result, name)
    end
  end
  return result
end

local tools = nil
-- Tools to auto-install with mason
M.get_tools = function()
  if tools == nil then
    tools = M.groups_to_tools(
      M.filter_executable_groups("tool", M.install_groups.tool)
    )
  end
  return tools
end

-- LSPs to install with mason via mason-lspconfig
M.get_mason_lsps = function()
  return M.groups_to_tools(
    M.filter_executable_groups("mason-lsp", M.install_groups.lsp)
  )
end

M.get_mason_lspconfig_handlers = function(middleware)
  local handlers = {}
  for name, resolver in pairs(mason_lspconfig_resolvers) do
    handlers[name] = resolver(middleware)
  end
  return handlers
end

-- calling resolver() eventually calls the lsp_resolver from appropriate
-- config_map, i.e. it does
-- require("lspconfig")[config.name].setup(middleware(config.lspconfig()))
-- to initialize the lsp
M.setup_unmanaged_lsps = function(middleware)
  vim.iter(lspconfig_resolvers):each(function(_, resolver)
    resolver(middleware)
  end)
end
