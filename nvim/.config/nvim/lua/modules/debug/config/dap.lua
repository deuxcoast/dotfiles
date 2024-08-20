-- TODO: install nvim lua DAP
-- Maybe this could be a good reference:
-- https://github.com/ibhagwan/nvim-lua/blob/main/lua/plugins/dap/lua.lua

--- mfussenegger/nvim-dap
local present_dap, dap = pcall(require, "dap")

if not present_dap then
  return
end

require("config.debug.dap_config")
-- local h = require("config/debug/debug_helpers")

require("nvim-dap-virtual-text").setup({})

local sign = vim.fn.sign_define

-- catppuccin colors
sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

local set = vim.keymap.set

set("n", "<F1>", dap.continue, { desc = "dap: continue" })
set("n", "<F2>", dap.step_into, { desc = "dap: step into" })
set("n", "<F3>", dap.step_over, { desc = "dap: step over" })
set("n", "<F4>", dap.step_out, { desc = "dap: step out" })
set("n", "<F5>", dap.step_back, { desc = "dap: step back" })
set("n", "<F11>", dap.restart, { desc = "dap: restart" })
set("n", "<F12>", dap.terminate, { desc = "dap: terminate" })

set("n", "<leader>b", dap.toggle_breakpoint, { desc = "dap: toggle brkpt" })
-- temporarily removes all breakpoints, sets a breakpoint at the cursor, resumes
--execution and then adds back breakpoints
set("n", "<leader>db", dap.run_to_cursor, { desc = "dap: run to cursor" })

-- Eval under cursor
set("n", "<leader>?", function()
  ---@diagnostic disable-next-line: missing-fields
  require("dapui").eval(nil, { enter = true })
end, { desc = "dap: eval under cursor" })
set("n", "<leader>dk", function()
  dap.up()
end, { desc = "dap: dap.up()" })
set("n", "<leader>dj", function()
  dap.down()
end, { desc = "dap: dap.down()" })
set("n", "<leader>dr", function()
  dap.repl.open({}, "vsplit")
end, { desc = "dap: open repl" })

------------------------------------------------------
----- Dap Go

local present_dap_go, dap_go = pcall(require, "dap-go")

if present_dap_go then
  dap_go.setup()
  set("n", "<leader>dgt", function()
    dap_go.debug_test()
  end, { desc = "dap go: dbg test" })
  set("n", "<leader>dgl", function()
    dap_go.debug_last_test()
  end, { desc = "dap go: dbg last test" })
end

------------------------------------------------------
----- Dap UI
local present_dapui, dapui = pcall(require, "dapui")

if present_dapui then
  ---@diagnostic disable-next-line: missing-fields
  dapui.setup({
    layouts = {
      {
        elements = {
          {
            id = "scopes",
            size = 0.25,
          },
          {
            id = "breakpoints",
            size = 0.25,
          },
          {
            id = "stacks",
            size = 0.25,
          },
          {
            id = "watches",
            size = 0.25,
          },
        },
        position = "left",
        size = 0.28,
      },
      {
        elements = {
          {
            id = "repl",
            size = 0.5,
          },
          {
            id = "console",
            size = 0.5,
          },
        },
        position = "bottom",
        size = 0.2,
      },
    },
  })
  set("n", "<leader>du", function()
    dapui.toggle()
  end)
  set("v", "<A-e>", function()
    dapui.eval()
  end)

  -- dap.listeners.after.event_initialized["dapui_config"] = function()
  --     dapui.open()
  -- end
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
end

------------------------------------------------------
----- Dap telescope
local present_telescope, telescope = pcall(require, "telescope")

if present_telescope then
  telescope.load_extension("dap")
  set("n", "<leader>df", ":Telescope dap frames<CR>", { desc = " dap frames" })
  set("n", "<leader>dc", ":Telescope dap commands<CR>", { desc = " dap commands" })
  set("n", "<leader>dl", ":Telescope dap list_breakpoints<CR>", { desc = " dap list brkpts" })
end
