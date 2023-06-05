local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("LuaOptions", { clear = true })
autocmd("FileType", {
	group = "LuaOptions",
	pattern = { "lua" },
	command = "setlocal shiftwidth=3 tabstop=3 expandtab",
})
autocmd("BufWritePre", {
	pattern = { "*.lua" },
	callback = function()
		require("stylua").format()
	end,
})
