local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("CmdLineLeave", {
   group = augroup("CmdLineFader", { clear = true }),
   callback = function()
      vim.fn.timer_start(5000, function()
         vim.cmd([[ echon ' ' ]])
      end)
   end,
})

autocmd("FileType", {
   group = augroup("ExitShortcut", { clear = true }),
   pattern = {
      "PlenaryTestPopup",
      "fugitiveblame",
      "help",
      "httpResult",
      "lspinfo",
      "notify",
      "qf",
      "spectre_panel",
      "startuptime",
      "tsplayground",
   },
   callback = function(event)
      vim.bo[event.buf].buflisted = false
		-- stylua: ignore
		vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true })
   end,
})

vim.fn.sign_define(
   "DiagnosticSignInfo",
   { text = "", numhl = "DiagnosticInformation", texthl = "DiagnosticInformation" }
)
vim.fn.sign_define("DiagnosticSignWarn", { text = "⚠", numhl = "DiagnosticWarn", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DiagnosticSignError", {
   text = "",
   numhl = "DiagnosticError",
   texthl = "DiagnosticError",
})
vim.fn.sign_define("DiagnosticSignHint", {
   text = "",
   numhl = "DiagnosticHint",
   texthl = "DiagnosticHint",
})

return {}
