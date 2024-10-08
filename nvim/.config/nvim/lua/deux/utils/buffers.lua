local M = {}

---@return string[] list current, normal, listed buffers
M.get_normal = function()
  return vim.tbl_filter(function(bufnr)
    return vim.bo[bufnr].buflisted
        and not require("deux.utils.buffer").is_special(bufnr)
  end, vim.api.nvim_list_bufs())
end

return M
