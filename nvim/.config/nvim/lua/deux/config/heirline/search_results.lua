local fn, api = vim.fn, vim.api
local hl = require("deux.config.heirline.theme").highlight
local Space = require("deux.config.heirline.util").Space

local SearchResults = {
	condition = function(self)
		local lines = api.nvim_buf_line_count(0)
		if lines > 50000 then
			return
		end

		local query = fn.getreg("/")
		if query == "" then
			return
		end

		if query:find("@") then
			return
		end

		local search_count = fn.searchcount({ recompute = 1, maxcount = -1 })
		local active = false
		if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
			active = true
		end
		if not active then
			return
		end

		query = query:gsub([[^\V]], "")
		query = query:gsub([[\<]], ""):gsub([[\>]], "")

		self.query = query
		self.count = search_count
		return true
	end,
	{
		provider = function(self)
			return table.concat({
				-- ' ', self.query, ' ', self.count.current, '/', self.count.total, ' '
				" ",
				self.count.current,
				"/",
				self.count.total,
				" ",
			})
		end,
		hl = hl.SearchResults,
	},
	Space,
}

return SearchResults
