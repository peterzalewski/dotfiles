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
autocmd({ "BufNewFile", "BufRead" }, {
	group = "FtpluginPython",
	pattern = { "*.aurora" },
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_option(buf, "filetype", "python")
	end,
})
