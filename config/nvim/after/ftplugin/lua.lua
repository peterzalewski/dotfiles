local vo = vim.opt_local
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vo.shiftwidth = 3
vo.tabstop = 3
vo.expandtab = true

augroup("FtpluginLua", { clear = true })
autocmd("BufWritePre", {
	group = "FtpluginLua",
	pattern = { "*.lua" },
	callback = function()
		require("stylua").format()
	end,
})
