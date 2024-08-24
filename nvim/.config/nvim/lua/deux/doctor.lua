local M = {}

M.warnings = {}
M.errors = {}

M.error = function(params)
  table.insert(M.errors, params)
end

M.warn = function(params)
  table.insert(M.warnings, params)
end

vim.api.nvim_create_user_command("DeuxDoctorErrors", function()
  vim.cmd.Bufferize("lua vim.print(require('deux.doctor').errors)")
end, { desc = "Show DeuxDoctor errors" })

vim.api.nvim_create_user_command("DeuxDoctorWarnings", function()
  vim.cmd.Bufferize("lua vim.print(require('deux.doctor').warnings)")
end, { desc = "Show DeuxDoctor warnings" })

return M
