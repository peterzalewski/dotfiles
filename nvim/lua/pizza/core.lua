local active_bg = "#303446"
local inactive_bg = "#2B2E3F"

return {
	{ "nvim-lua/plenary.nvim", lazy = false, priority = 1000 },
	{ "christoomey/vim-tmux-navigator" },
	{
		"ibhagwan/fzf-lua",
		lazy = true,
		cmd = "FzfLua",
		dependencies = { "devicons" },
		opts = function()
			local catppuccin = require("catppuccin.palettes.frappe")
			local actions = require("fzf-lua.actions")
			return {
				actions = {
					files = {
						["default"] = actions.file_edit,
						["ctrl-h"] = actions.file_split,
						["ctrl-v"] = actions.file_vsplit,
						["alt-q"] = actions.file_sel_to_qf,
						["alt-l"] = actions.file_sel_to_ll,
					},
				},
				defaults = {
					fzf_opts = {
						["--info"] = "hidden",
					},
				},
				hls = {
					border = "FloatBorder",
					cursorLine = "LineNr",
					help_border = "FloatBorder",
					preview_border = "FloatBorder",
					preview_title = "Identifier",
					scrollborder_f = "LineNr",
					scrollfloat_f = "LineNr",
				},
				winopts = {
					border = "single",
					preview = {
						border = "sharp",
						scrollbar = "border",
					},
				},
				nbsp = "\xc2\xa0",
			}
		end,
		keys = {
			{ "<leader>b", "<cmd>FzfLua buffers<cr>", desc = "Fuzzy find open buffers" },
			{ "<leader>fc", "<cmd>FzfLua git_branches<cr>", desc = "Fuzzy find and check out a git branch" },
			{ "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Fuzzy find keywords in Neovim help" },
			{ "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Fuzzy find keymaps" },
			{ "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Fuzzy find recently opened files" },
			{ "<leader>fr", "<cmd>FzfLua registers<cr>", desc = "Fuzzy find register contents" },
			{ "<leader>t", "<cmd>FzfLua files<cr>", desc = "Fuzzy find files" },
			{ "<leader>gc", "<cmd>FzfLua grep_cword<cr>", desc = "Live grep for the current word" },
			{ "<leader>gg", "<cmd>FzfLua live_grep_native<cr>", desc = "Live grep through the current project" },
			{ "<leader>gp", "<cmd>FzfLua grep_last<cr>", desc = "Live grep for the previous pattern" },
			{
				"<C-r>",
				"<cmd>FzfLua registers<cr>",
				mode = "i",
				desc = "Fuzzy find register contents",
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			window = {
				border = "single",
			},
		},
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = active_bg })
		end,
	},
	{
		"stevearc/overseer.nvim",
		opts = {},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
      open_mapping = "<C-Space>",
			direction = "float",
			float_opts = { border = "single" },
		},
	},
	-- {
	--   'smoka7/hop.nvim',
	--   version = "*",
	--   opts = {},
	--   init = function ()
	--     local hop = require('hop')
	--     local directions = require('hop.hint').HintDirection
	--     vim.keymap.set('', 'f', function()
	--       hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
	--     end, {remap=true})
	--     vim.keymap.set('', 'F', function()
	--       hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
	--     end, {remap=true})
	--     vim.keymap.set('', 't', function()
	--       hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
	--     end, {remap=true})
	--     vim.keymap.set('', 'T', function()
	--       hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
	--     end, {remap=true})
	--   end
	-- }
}
