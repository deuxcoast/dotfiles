local Ruler = {
	-- :help 'statusline'
	-- ------------------
	-- %-2 : make item takes at least 2 cells and be left justified
	-- %l  : current line number
	-- %L  : number of lines in the buffer
	-- %c  : column number
	-- %V  : virtual column number as -{num}.  Not displayed if equal to '%c'.
	provider = " %9(%l:%L%)  %-3(%c%V%) ",
	hl = { bold = true },
}

return Ruler
