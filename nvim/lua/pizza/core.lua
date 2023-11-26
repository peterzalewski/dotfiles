return {
	{ "nvim-lua/plenary.nvim" },
	{ "christoomey/vim-tmux-navigator" },
	{
		"ibhagwan/fzf-lua",
		dependencies = { "devicons" },
		opts = function()
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
			}
		end,
	},
	{
		"folke/which-key.nvim",
		opts = {
			window = {
				border = "single",
			},
		},
		config = function(_, opts)
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup(opts)
		end,
	},
}
