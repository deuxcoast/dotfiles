-- ===========================================================================
-- Change vim behavior via autocommands
-- ===========================================================================

local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

local groups = {}
local augroup = function(name, opts)
  if not groups[name] then
    opts = opts or {}
    groups[name] = vim.api.nvim_create_augroup(name, opts)
  end
  return groups[name]
end

local autocmd = vim.api.nvim_create_autocmd

if has_ui then
  -- @TODO keep an eye on https://github.com/neovim/neovim/issues/23581
  autocmd("WinLeave", {
    desc = "Toggle close->open loclist so it is always under the correct window",
    callback = function()
      if vim.bo.buftype == "quickfix" then
        -- Was in loclist already
        return
      end
      local loclist_winid = vim.fn.getloclist(0, { winid = 0 }).winid
      if loclist_winid == 0 then
        return
      end

      local leaving = vim.api.nvim_get_current_win()
      autocmd("WinEnter", {
        callback = function()
          if vim.bo.buftype == "quickfix" then
            -- Left main window and went into the loclist
            return
          end
          local entering = vim.api.nvim_get_current_win()
          vim.o.eventignore = "all"
          vim.api.nvim_set_current_win(leaving)
          vim.cmd.lclose()
          vim.cmd.lwindow()
          vim.api.nvim_set_current_win(entering)
          vim.o.eventignore = ""
        end,
        once = true,
      })
    end,
    group = augroup("deuxwindow"),
  })

  autocmd("VimResized", {
    desc = "Automatically resize windows in all tabpages when resizing Vim",
    callback = function()
      vim.schedule(function()
        vim.cmd("tabdo wincmd =")
      end)
    end,
    group = augroup("deuxwindow"),
  })

  autocmd("QuitPre", {
    desc = "Auto close corresponding loclist when quitting a window",
    callback = function()
      if vim.bo.filetype ~= "qf" then
        vim.cmd("silent! lclose")
      end
    end,
    nested = true,
    group = augroup("deuxwindow"),
  })

  autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
    desc = "Start in insert mode when entering a terminal",
    callback = function(args)
      if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
        vim.cmd("startinsert")
      end
    end,
    group = augroup("deuxwindow"),
  })

  autocmd("BufReadPre", {
    desc = "Disable linting and syntax highlighting for large and minified files",
    callback = function(args)
      -- See the treesitter highlight config too
      if require("deux.utils.buffer").is_huge(args.file) then
        vim.cmd.syntax("manual")
      end
    end,
    group = augroup("deuxreading"),
  })

  autocmd("BufReadPre", {
    pattern = "*.min.*",
    desc = "Disable syntax on minified files",
    command = "syntax manual",
    group = augroup("deuxreading"),
  })

  -- https://vi.stackexchange.com/questions/11892/populate-a-git-commit-template-with-variables
  autocmd("BufRead", {
    pattern = "COMMIT_EDITMSG",
    desc = "Replace tokens in commit-template",
    callback = function()
      local tokens = {}
      tokens.BRANCH = vim
          .system({ "git", "rev-parse", "--abbrev-ref", "HEAD" })
          :wait().stdout
          :gsub("\n", "")

      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      for i, line in ipairs(lines) do
        lines[i] = line:gsub("%$%{(%w+)%}", function(s)
          return s:len() > 0 and tokens[s] or ""
        end)
      end
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    end,
    group = augroup("deuxreading"),
  })

  autocmd("BufEnter", {
    desc = "Read only mode (un)mappings",
    callback = function()
      local is_editable = require("deux.utils.buffer").is_editable
      if is_editable(0) then
        return
      end

      local closebuf = function()
        if is_editable(0) then
          return
        end
        local totalWindows = vim.fn.winnr("$")
        if totalWindows > 1 then
          vim.cmd.close()
        else
          -- Requires nobuflisted on quickfix!
          vim.cmd.bprevious()
        end
      end
      vim.keymap.set("n", "Q", closebuf, { buffer = true })
      vim.keymap.set("n", "q", closebuf, { buffer = true })
    end,
    group = augroup("deuxreading"),
  })

  autocmd({ "BufNewFile", "BufRead", "BufFilePost" }, {
    pattern = { "*.lua" },
    desc = "Apply stylua.toml spacing if no editorconfig",
    callback = function()
      vim.schedule(function()
        if not vim.b.editorconfig or vim.tbl_isempty(vim.b.editorconfig) then
          require("deux.editing").from_stylua_toml()
        end
      end)
    end,
    group = augroup("deuxediting"),
  })
end

-- yanky.nvim providing this
-- autocmd("TextYankPost", {
--   desc = "Highlight yanked text after yanking",
--   callback = function()
--     vim.highlight.on_yank({
--       higroup = "IncSearch",
--       timeout = 150,
--       on_visual = true,
--     })
--   end,
--   group = augroup("deuxediting"),
-- })

autocmd({ "BufWritePre", "FileWritePre" }, {
  desc = "Create missing parent directories on write",
  callback = function(args)
    local status, result = pcall(function()
      -- this is a remote url
      if args.file:find("://") then
        return
      end
      local dir = assert(
        vim.fn.fnamemodify(args.file, ":h"),
        ("could not get dirname: %s"):format(args.file)
      )
      -- dir already exists
      if vim.uv.fs_stat(dir) then
        return
      end
      assert(vim.fn.mkdir(dir, "p") == 1, ("could not mkdir: %s"):format(dir))
      return assert(
        vim.fn.fnamemodify(dir, ":p:~"),
        ("could not resolve full path: %s"):format(dir)
      )
    end)
    if type(result) == "string" then
      vim.notify(result, vim.log.levels[status and "INFO" or "ERROR"], {
        title = "Create dir on write",
      })
    end
  end,
  group = augroup("deuxsaving"),
})

if has_ui then
  autocmd("User", {
    pattern = "FormatterAdded",
    desc = "Notify neovim a formatter has been added for the buffer",
    callback = function()
      -- noop - heirline listens for this event
    end,
    group = augroup("deuxformatter"),
  })

  -- https://github.com/neovim/neovim/blob/7a44231832fbeb0fe87553f75519ca46e91cb7ab/runtime/lua/vim/lsp.lua#L1529-L1533
  -- LspAttach happens before on_attach, so can still use on_attach to do more stuff or
  -- override this

  autocmd("LspAttach", {
    desc = "Bind LSP related mappings",
    callback = require("deux.mappings").bind_on_lspattach,
    group = augroup("deuxlsp"),
  })

  autocmd("LspAttach", {
    desc = "Set flag to format on save when first capable LSP attaches to buffer",
    callback = require("deux.utils.format").enable_on_lspattach,
    group = augroup("deuxlsp"),
  })

  autocmd("LspDetach", {
    desc = "Unbind LSP related mappings on last client detach",
    callback = require("deux.mappings").unbind_on_lspdetach,
    group = augroup("deuxlsp"),
  })

  autocmd("LspDetach", {
    desc = "Unset flag to format on save when last capable LSP detaches from buffer",
    callback = require("deux.utils.format").disable_on_lspdetach,
    group = augroup("deuxlsp"),
  })

  autocmd({ "BufWritePre", "FileWritePre" }, {
    desc = "Format with LSP on save",
    callback = require("deux.utils.format").format_on_save,
    group = augroup("deuxlsp"),
  })

  -- temporary fix, winbars not updating
  local fix_winbar_events = vim.tbl_extend(
    "keep",
    require("deux.heirline.diagnostics").update,
    require("deux.heirline.lsp").update,
    { "User PackageInfoProgress" } -- clear winbar status msg when done
  )
  fix_winbar_events = vim.tbl_filter(function(event)
    return vim.fn.exists(("##%s"):format(event)) == 1
  end, fix_winbar_events)
  autocmd(fix_winbar_events, {
    desc = "FIX - heirline does not always update winbars",
    callback = vim.schedule_wrap(function()
      vim.cmd.redrawstatus({ bang = true })
    end),
  })
end
