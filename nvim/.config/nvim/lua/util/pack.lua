local uv, fn = vim.loop, vim.fn

---@class util.pack
local pack = {}
pack.__index = pack

function pack:load_modules_packages()
  ---@diagnostic disable-next-line: param-type-mismatch
  local modules_dir = vim.fs.joinpath(self.config_path, "lua", "modules")
  self.repos = {}

  local list = vim.fs.find("package.lua", { path = modules_dir, type = "file", limit = 10 })
  if #list == 0 then
    return
  end

  local disable_modules = {}
  if fn.exists("g:disable_modules") == 1 then
    disable_modules = vim.split(vim.g.disable_modules, ",", { trimempty = true })
  end

  for _, f in pairs(list) do
    local _, pos = f:find(modules_dir)
    f = f:sub(pos - 6, #f - 4)
    if not vim.tbl_contains(disable_modules, f) then
      require(f)
    end
  end
end

function pack:boot_strap()
  self.data_path = fn.stdpath("data")
  self.config_path = fn.stdpath("config")
  local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  -- if lazy is not present, then clone the repository
  if not uv.fs_stat(lazy_path) then
    local out = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      "https://github.com/folke/lazy.nvim.git",
      lazy_path,
    })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out,                            "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end

  vim.opt.runtimepath:prepend(lazy_path)
  local lazy = require("lazy")
  local opts = {
    dev = {
      path = "~/deuxcoast/nvim-plugins-local",
    },
    change_detection = {
      notify = false,
    },
  }
  self:load_modules_packages()
  lazy.setup(self.repos, opts)

  -- Clean up the `pack` table by removing any non-function properties
  for k, v in pairs(self) do
    if type(v) ~= "function" then
      self[k] = nil
    end
  end
end

function pack.package(repo)
  if not pack.repos then
    pack.repos = {}
  end
  table.insert(pack.repos, repo)
end

return pack
