return {
	{ "fladson/vim-kitty" },
	{ "google/vim-jsonnet" },
	{ "L3MON4D3/LuaSnip", name = "luasnip", version = "v1.*", build = "make install_jsregexp" },
	{
		"danymat/neogen",
		dependencies = { "treesitter", "luasnip" },
		keys = {
			{
				"<leader>nf",
				function()
					require("neogen").generate()
				end,
			},
		},
		opts = {
			enabled = true,
			snippet_engine = "luasnip",
			languages = {
				python = {
					template = {
						annotation_convention = "reST",
					},
				},
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"devicons",
			"luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("pizza.plugins.cmp")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		build = ":TSUpdate",
		version = false,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		event = { "BufReadPost", "BufNewFile" },
		opts = {
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
						["]a"] = "@parameter.outer",
						["]s"] = { query = "@scope", query_group = "locals" },
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.outer",
						["[s"] = { query = "@scope", query_group = "locals" },
					},
				},
			},
			context_commentstring = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Space><Space>",
					node_incremental = "<Space>",
					scope_incremental = "<Tab>",
					node_decremental = "<C-Space>",
				},
			},
			ensure_installed = {
				"bash",
				"go",
				"html",
				"json",
				"lua",
				"rust",
				"python",
				"yaml",
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "devicons" },
		keys = {
			{ "<leader>d", ":TroubleToggle<CR>", desc = "Open diagnostics" },
		},
	},
	{
		"stevearc/aerial.nvim",
		lazy = true,
		keys = {
			{ "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Open the Aerial window" },
		},
		opts = {
			on_attach = function(bufnr)
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { silent = true, buffer = bufnr })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { silent = true, buffer = bufnr })
			end,
			attach_mode = "global",
			highlight_on_jump = false,
		},
	},
}
