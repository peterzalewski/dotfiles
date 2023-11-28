return {
	{ "peterzalewski/vim-surround", lazy = false },
	{
		"numToStr/Comment.nvim",
		lazy = false,
		opts = { ignore = "^\\s*$" },
		keys = {
			{
				"<C-g>",
				function()
					require("Comment.api").toggle.linewise()
				end,
				mode = "i",
				desc = "Comment line while inserting",
			},
		},
	},
	{
		"junegunn/vim-easy-align",
		lazy = false,
		config = function()
			vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)", { silent = true, remap = true })
		end,
	},
}
