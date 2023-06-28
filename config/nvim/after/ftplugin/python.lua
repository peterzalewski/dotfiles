local vo = vim.opt_local
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vo.shiftwidth = 4
vo.tabstop = 4
vo.expandtab = true
vo.textwidth = 120
vo.colorcolumn = "+1"

augroup("FtpluginPython", { clear = true })
autocmd("BufWritePre", {
	group = "FtpluginPython",
	pattern = { "*.py" },
	callback = function() end,
})