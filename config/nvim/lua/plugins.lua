local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("CmdLineLeave", {
	group = augroup("CmdLineFader", { clear = true }),
	callback = function()
		vim.fn.timer_start(5000, function()
			vim.cmd([[ echon ' ' ]])
		end)
	end,
})

autocmd("BufWritePost", {
	group = augroup("packer_user_config", { clear = true }),
	pattern = "plugins.lua",
	callback = function()
		vim.cmd([[ source <afile> | PackerCompile ]])
	end,
})

-- Get value from
active_bg = "#303446"
inactive_bg = "#2B2E3F"

return require("packer").startup({
	-- https://github.com/wbthomason/packer.nvim#specifying-plugins
	function(use)
		use({ "wbthomason/packer.nvim" })
		use({ "nvim-lua/plenary.nvim" })
		use({
			"catppuccin/nvim",
			as = "catppuccin",
			config = function()
				require("catppuccin").setup({
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
				})

				vim.cmd.colorscheme("catppuccin")
			end,
		})
		use({ "peterzalewski/vim-surround" })
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})
		use({
			"junegunn/vim-easy-align",
			config = function()
				vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)", { silent = true, remap = true })
			end,
		})

		-- LSP
		use({
			"neovim/nvim-lspconfig",
			requires = {
				"folke/neodev.nvim",
				"simrat39/rust-tools.nvim",
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
			},
			config = function()
				require("plugins.lspconfig")
			end,
		})
		-- Autocomplete
		use({
			"hrsh7th/cmp-nvim-lsp",
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/nvim-cmp",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"saadparwaiz1/cmp_luasnip",
				"onsails/lspkind.nvim",
			},
			config = function()
				require("plugins.cmp")
			end,
		})
		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				local null_ls = require("null-ls")
				null_ls.setup({
					sources = {
						null_ls.builtins.formatting.black.with({
							extra_args = { "--config", ".arc/linters/black/black.toml" },
						}),
					},
				})
			end,
		})

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			requires = {
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			config = function()
				require("plugins.treesitter")
			end,
		})

		use({
			"ibhagwan/fzf-lua",
			requires = { "nvim-tree/nvim-web-devicons" },
		})
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "nvim-tree/nvim-web-devicons", opt = true },
			config = function()
				local theme = require("catppuccin.utils.lualine")("frappe")
				local colors = require("catppuccin.palettes").get_palette("frappe")
				theme.normal.a.gui = nil
				theme.normal.c.bg = active_bg
				theme.inactive.a.bg = colors.lavender
				theme.inactive.a.fg = colors.base
				theme.inactive.b.bg = inactive_bg
				theme.inactive.c.bg = inactive_bg

				require("lualine").setup({
					options = {
						disabled_filetypes = {
							"aerial",
							"NvimTree",
							"Trouble",
							"quickfix",
						},
						theme = theme,
					},
					sections = {
						lualine_a = {
							{
								"mode",
								color = {
									fg = active_bg,
								},
								separator = { left = "", right = "" },
							},
						},
						lualine_c = { { "filename", path = 3 } },
						lualine_x = {
							{
								"filetype",
							},
						},
						lualine_z = {
							{
								"location",
								separator = { right = "" },
							},
						},
					},
					inactive_sections = {
						lualine_x = {},
						lualine_a = {
							{
								"filename",
								separator = { left = "", right = "" },
								right_padding = 2,
							},
						},
						lualine_b = {},
						lualine_c = {},
					},
				})
			end,
		})
		use({ "christoomey/vim-tmux-navigator" })
		use({
			"L3MON4D3/LuaSnip",
			tag = "v1.*",
			run = "make install_jsregexp",
			config = function()
				require("plugins.snippets")
			end,
		})
		use({
			"j-hui/fidget.nvim",
			config = function()
				require("fidget").setup({
					text = { spinner = "dots" },
					window = {
						blend = 0,
					},
				})
			end,
		})
		use({ "wesleimp/stylua.nvim" })
		use({
			"folke/trouble.nvim",
			requires = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("trouble").setup({})
			end,
		})
		use({ "Bekaboo/deadcolumn.nvim" })

		use({ "fladson/vim-kitty" })

		use({
			"danymat/neogen",
			requires = { "nvim-treesitter/nvim-treesitter" },
			config = function()
				require("neogen").setup({
					enabled = true,
					snippet_engine = "luasnip",
					languages = {
						python = {
							template = {
								annotation_convention = "reST",
							},
						},
					},
				})
			end,
		})
		use({
			"nvim-tree/nvim-tree.lua",
			requires = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("nvim-tree").setup({})
				vim.keymap.set(
					{ "n" },
					"gt",
					":NvimTreeFocus<CR>",
					{ silent = true, desc = "Open and focus file tree" }
				)
			end,
		})
		use({
			"stevearc/aerial.nvim",
			config = function()
				require("aerial").setup({
					on_attach = function(bufnr)
						vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { silent = true, buffer = bufnr })
						vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { silent = true, buffer = bufnr })
					end,
					attach_mode = "global",
					highlight_on_jump = false,
				})
			end,
		})
		use({ "metakirby5/codi.vim" })
		use({ "shortcuts/no-neck-pain.nvim", tag = "*" })
		use({
			"folke/which-key.nvim",
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
				require("which-key").setup({
					window = {
						border = "single",
					},
				})
			end,
		})
		use({
			"goolord/alpha-nvim",
			requires = { "nvim-tree/nvim-web-devicons" },
			config = function()
				local alpha = require("alpha")
				local startify = require("alpha.themes.startify")

				startify.section.header.val = {
					[[           ■                                                                   ]],
					[[            ▀▄▄▄▄                                                              ]],
					[[         ▄▄█████████▄▄                ▄                                        ]],
					[[     ░  █████▀   ▀█████          ▄▄██▀▄                    ▄■                  ]],
					[[   ░   ▐████▌  ░  ▐████▌        ▐██████▌    ▄ ▀ ■▄     ▄▄██▄                   ]],
					[[  ░    █████  ░  ▄▄█████         ▀████▀▄   ■      █   ▐███▄█▌         ░        ]],
					[[ ░░░   █████   ▄▀  ██████▄     ■▄   ▀   ■       ▄██▌ ▄▀████▀            ░      ]],
					[[  ░░  ▐████▌ ░ ▐   ▐████▐██▄     ▀▀▀███▀▄   ▄  ▐██▀█▄   ▀▀  █▄           ░░    ]],
					[[   ░░ ▐████▌░░░ ▀■ ▐████▌███▄ ▄███▀▄ █▌  ■▄█▀█▄████▌ ▀████▀▄▐█▌▄▄███▄▄    ░░   ]],
					[[  ░░░░▐████▌░░░░░  ▐████▌▐████▀▀████▌█  ▄██▌  ▀████  ▐███▌ ▄████▀  ██▄█ ░░     ]],
					[[   ░░░▐████▌░░░░░░ ▐████▌ ███▌ ████▀ █ ▐███ ░ ▐███▌  ████  ████  ░ ▐███▌  ■    ]],
					[[  ░░ ░▐████▌░░░░░░░▐████▌▐███   ▀  ▄██ ████ ░ ████  ▐███▌  ▐███▌ ░ █████▄▀ ░   ]],
					[[  ░   ▐████▌ ░░░░░ ▐████▌████  ░  ███▌ ████ ░ ████  ████▄▀■▄████  ▐█████▌   ░░ ]],
					[[   ░   █████  ░░░  █████ ████▌ ▄ ▐███  ▐███ ░ ████▄▀▐███▌  ▐████▌  █████   ░░  ]],
					[[       █████ ░░░   █████ █████▀  ████▌  ███▌  ▐███▌  ███ ░ █████▌  ▐██▀   ░    ]],
					[[       ▐████▌ ░   ▐████▌ ████▌ ░ ▐████  ■▀██▄ ▄▀███ ▄█▀   ▐█████  ▄▀█          ]],
					[[        █████▄   ▄█████ ▐████   ▄▄████▄▀   ▀▀▀ ▐███  ▌     ▀█▀▀     ▌    ░     ]],
					[[         ▀▀████▄████▀▀  ▐██▀   ▀  ██▀      ▄▀■ ███▌ ■               ■          ]],
					[[              ▀▀█▀   ▀▄▄▀▀    ■   █      ▄▀█  ▐███       roy/sac               ]],
					[[                 ▀■               ▌     ▐██▌  ███▌                             ]],
					[[                                        ▀███▄ ██▀                              ]],
					[[                                           ▀▀█▀                                ]],
				}

				alpha.setup(startify.config)
			end,
		})
		use({
			"olimorris/persisted.nvim",
			config = function()
				require("persisted").setup()
			end,
		})
	end,

	-- https://github.com/wbthomason/packer.nvim#custom-initialization
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
