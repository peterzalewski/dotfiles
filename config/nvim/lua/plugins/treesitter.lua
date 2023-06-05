require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]c"] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[c"] = "@class.outer",
			},
		},
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<Space><Space>", -- set to `false` to disable one of the mappings
			node_incremental = "<Space>",
			scope_incremental = "<Tab>",
			node_decremental = "<C-Space>",
		},
	},
	ensure_installed = {
		"go",
		"lua",
		"rust",
		"python",
	},
})

-- require("treesitter-context").setup({})
