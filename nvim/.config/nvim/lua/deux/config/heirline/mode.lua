local heirline = require("heirline.utils")
local get_hl = heirline.get_highlight
local hl = require("deux.config.heirline.theme").highlight
local util = require("deux.config.heirline.util")
local icons = util.icons
local mode = util.mode

local Space = util.Space
local ReadOnly = util.ReadOnly

local ModeIndicator
do
	local VimMode
	do
		local NormalModeIndicator = {
			Space,
			{
				fallthrough = false,
				ReadOnly,
				{
					provider = icons.circle,
					hl = function()
						if vim.bo.modified then
							-- return { fg = hl.Mode.insert.bg }
							return { fg = get_hl("DiffChange").fg }
						else
							return hl.Mode.normal
						end
					end
				}
			},
			Space
		}

		local ActiveModeIndicator = {
			condition = function(self)
				return self.mode ~= 'normal'
			end,
			hl = { bg = hl.StatusLine.bg },
			heirline.surround(
				{ icons.powerline.left_rounded, icons.powerline.right_rounded },
				function(self) -- color
					return hl.Mode[self.mode].bg
				end,
				{
					{
						fallthrough = false,
						ReadOnly,
						{ provider = icons.circle }
					},
					Space,
					{
						provider = function(self)
							return util.mode_label[self.mode]
						end,
					},
					hl = function(self)
						return hl.Mode[self.mode]
					end
				}
			)
		}

		VimMode = {
			init = function(self)
				self.mode = mode[vim.fn.mode(1)] -- :h mode()
			end,
			condition = function() return vim.bo.buftype == '' end,
			{
				fallthrough = false,
				ActiveModeIndicator,
				NormalModeIndicator,
			}
		}
	end

	ModeIndicator = {
		fallthrough = false,
		-- HydraName,
		VimMode
	}
end

return ModeIndicator
