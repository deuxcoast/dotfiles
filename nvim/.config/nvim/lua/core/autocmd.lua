local au = vim.api.nvim_create_autocmd
local augroup = function(name)
  vim.api.nvim_create_augroup("deux_" .. name, { clear = true })
end

au("BufEnter", {
  group = augroup("lazy_keymap"),
  once = true,
  callback = function()
    require("core.maps")
  end,
  desc = "Lazy load my keymap and buffer relate commands and defaul opt plugins",
})

-- Highlight yanked text
au("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- match trailing whitespace when in normal mode
au({ "BufWinEnter", "InsertEnter" }, {
  group = augroup("trailing_whitespace"),
  command = "match Error /\\s\\+%#@<!$/",
})

-- unmatch trailing whitespace when in insert mode
au({ "InsertLeave" }, {
  group = augroup("trailing_whitespace"),
  command = "match Error /\\s\\+$/",
})
