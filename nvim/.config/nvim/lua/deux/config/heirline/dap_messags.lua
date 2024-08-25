local dap = require("dap")
local hl = require("deux.config.heirline.theme").highlight
local api = vim.api

local DapMessages = {
	-- display the dap messages only on the debugged file
	condition = function()
		-- local session = dap_available and dap.session()
		local session = dap.session()
		if session then
			local filename = api.nvim_buf_get_name(0)
			if session.config then
				local progname = session.config.program
				return filename == progname
			end
		end
		return false
	end,
	provider = function()
		return " " .. dap.status() .. " "
	end,
	hl = hl.DapMessages,
}

return DapMessages
