local autogrp = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("plugins")
require("bindings")
require("options")

active_bg = "#303446"
inactive_bg = "#2B2E3F"

local general = autogrp("General Settings", { clear = true })

autocmd("ColorScheme", {
	group = general,
	pattern = { "*" },
	callback = function()
		vim.api.nvim_set_hl(0, "WinSeparator", { bg = inactive_bg })
		vim.api.nvim_set_hl(0, "MsgArea", { bg = inactive_bg })
		vim.api.nvim_set_hl(0, "FidgetTitle", { fg = "#f2d5cf", bg = active_bg })
		vim.api.nvim_set_hl(0, "FidgetTask", { fg = "#f2d5cf", bg = active_bg })
	end,
})

autocmd("FocusLost", {
	group = general,
	callback = function()
		-- guifg=#c6d0f5 guibg=#303446
		vim.api.nvim_set_hl(0, "Normal", { fg = "#c6d0f5", bg = inactive_bg })
		vim.api.nvim_set_hl(0, "lualine_c_normal", { fg = "#c6d0f5", bg = inactive_bg })
	end,
})

autocmd("FocusGained", {
	group = general,
	callback = function()
		-- guifg=#c6d0f5 guibg=#303446
		vim.api.nvim_set_hl(0, "Normal", { fg = "#c6d0f5", bg = active_bg })
		vim.api.nvim_set_hl(0, "lualine_c_normal", { fg = "#c6d0f5", bg = active_bg })
	end,
})

autocmd("TextYankPost", {
	group = general,
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 700 })
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
