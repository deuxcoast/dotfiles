local hl = require("deux.config.heirline.theme").highlight
local devicons = require("nvim-web-devicons")
local util = require("deux.config.heirline.util")
local priority = util.priority

local ReadOnly = util.ReadOnly
local Null = util.Null

local bo, fn = vim.bo, vim.fn

local FileNameBlock, CurrentPath, FileName
do
	local FileIcon = {
		condition = function()
			return not ReadOnly.condition()
		end,
		init = function(self)
			local filename = self.filename
			local extension = fn.fnamemodify(filename, ":e")
			self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
		end,
		provider = function(self)
			if self.icon then
				return self.icon .. " "
			end
		end,
		hl = function(self)
			return { fg = self.icon_color }
		end,
	}

	local WorkDir = {
		condition = function(self)
			if bo.buftype == "" then
				return self.pwd
			end
		end,
		hl = hl.WorkDir,
		flexible = priority.WorkDir,
		{
			provider = function(self)
				return self.pwd
			end,
		},
		{
			provider = function(self)
				return fn.pathshorten(self.pwd)
			end,
		},
		Null,
	}

	CurrentPath = {
		condition = function(self)
			if bo.buftype == "" then
				return self.current_path
			end
		end,
		hl = hl.CurrentPath,
		flexible = priority.CurrentPath,
		{
			provider = function(self)
				return self.current_path
			end,
		},
		{
			provider = function(self)
				return fn.pathshorten(self.current_path, 2)
			end,
		},
		{ provider = "" },
	}

	FileName = {
		provider = function(self)
			return self.filename
		end,
		hl = hl.FileName,
	}

	FileNameBlock = {
		{ FileIcon, WorkDir, CurrentPath, FileName },
		-- This means that the statusline is cut here when there's not enough space.
		{ provider = "%<" },
	}
end
do
	local FileIcon = {
		condition = function()
			return not ReadOnly.condition()
		end,
		init = function(self)
			local filename = self.filename
			local extension = fn.fnamemodify(filename, ":e")
			self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
		end,
		provider = function(self)
			if self.icon then
				return self.icon .. " "
			end
		end,
		hl = function(self)
			return { fg = self.icon_color }
		end,
	}

	local WorkDir = {
		condition = function(self)
			if bo.buftype == "" then
				return self.pwd
			end
		end,
		hl = hl.WorkDir,
		flexible = priority.WorkDir,
		{
			provider = function(self)
				return self.pwd
			end,
		},
		{
			provider = function(self)
				return fn.pathshorten(self.pwd)
			end,
		},
		Null,
	}

	CurrentPath = {
		condition = function(self)
			if bo.buftype == "" then
				return self.current_path
			end
		end,
		hl = hl.CurrentPath,
		flexible = priority.CurrentPath,
		{
			provider = function(self)
				return self.current_path
			end,
		},
		{
			provider = function(self)
				return fn.pathshorten(self.current_path, 2)
			end,
		},
		{ provider = "" },
	}

	FileName = {
		provider = function(self)
			return self.filename
		end,
		hl = hl.FileName,
	}

	FileNameBlock = {
		{
			FileIcon,
			WorkDir,
			CurrentPath,
			FileName,
		},
		-- This means that the statusline is cut here when there's not enough space.
		{ provider = "%<" },
	}
end

return FileNameBlock
