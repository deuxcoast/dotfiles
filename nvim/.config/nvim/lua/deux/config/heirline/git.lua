local conditions = require("heirline.conditions")
local hl = require("deux.config.heirline.theme").highlight
local Space = require("deux.config.heirline.util").Space

local GitBranch = {
	condition = conditions.is_git_repo,
	init = function(self)
		self.git_status = vim.b.gitsigns_status_dict
	end,
	hl = hl.Git.branch,
	provider = function(self)
		return table.concat({ " ", self.git_status.head })
	end,
}

local GitChanges = {
	condition = function(self)
		if conditions.is_git_repo() then
			self.git_status = vim.b.gitsigns_status_dict
			local has_changes = self.git_status.added ~= 0
				or self.git_status.removed ~= 0
				or self.git_status.changed ~= 0
			return has_changes
		end
	end,
	provider = "  ",
	-- hl = hl.Git.branch
	-- hl = hl.Git.changed
	-- hl = hl.Git.added
	-- hl = hl.Git.removed
	hl = hl.Git.dirty,
}

local Git = { GitBranch, GitChanges, Space }

return Git
