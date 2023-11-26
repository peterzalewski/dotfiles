local autogrp = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local active_bg = "#303446"
local inactive_bg = "#2B2E3F"
local general = autogrp("General Settings", { clear = true })

autocmd("ColorScheme", {
	group = general,
	pattern = { "*" },
	callback = function()
		vim.api.nvim_set_hl(0, "WinSeparator", { bg = inactive_bg })
		vim.api.nvim_set_hl(0, "WinSeparatorNC", { bg = active_bg })
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

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			highlight_overrides = {
				frappe = function(colors)
					return {
						LineNr = { fg = colors.rosewater },
						LineNrAbove = { fg = colors.surface1 },
						LineNrBelow = { fg = colors.surface1 },
						MsgArea = { bg = inactive_bg },
					}
				end,
			},
			dim_inactive = {
				enabled = true,
				percentage = 0.25,
			},
			flavour = "frappe",
			integrations = {
				aerial = true,
				cmp = true,
				fidget = true,
				nvimtree = true,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
