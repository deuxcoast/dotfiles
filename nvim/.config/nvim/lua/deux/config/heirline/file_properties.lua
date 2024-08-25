local hl = require("deux.config.heirline.theme").highlight
local bo = vim.bo
local FileProperties = {
	condition = function(self)
		self.filetype = bo.filetype

		local encoding = (bo.fileencoding ~= '' and bo.fileencoding) or vim.o.encoding
		self.encoding = (encoding ~= 'utf-8') and encoding or nil

		local fileformat = bo.fileformat

		-- if fileformat == 'dos' then
		--    fileformat = ' '
		-- elseif fileformat == 'mac' then
		--    fileformat = ' '
		-- else  -- unix'
		--    fileformat = ' '
		--    -- fileformat = nil
		-- end

		if fileformat == 'dos' then
			fileformat = 'CRLF'
		elseif fileformat == 'mac' then
			fileformat = 'CR'
		else -- 'unix'
			-- fileformat = 'LF'
			---@diagnostic disable-next-line: cast-local-type
			fileformat = nil
		end

		self.fileformat = fileformat

		return self.fileformat or self.encoding
	end,
	provider = function(self)
		local sep = (self.fileformat and self.encoding) and ' ' or ''
		return table.concat { ' ', self.fileformat or '', sep, self.encoding or '', ' ' }
	end,
	hl = hl.FileProperties,
}

return FileProperties
