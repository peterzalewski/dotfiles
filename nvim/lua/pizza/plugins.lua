---@diagnostic disable-next-line: unused-local
local inactive_bg = "#2B2E3F"

return {
   {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
         library = {
            {
               path = "luvit-meta/library",
               words = { "vim%.uv" },
            },
         },
      },
   },
   {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
      name = "devicons",
   },
   {
      "nvim-tree/nvim-tree.lua",
      lazy = true,
      dependencies = { "devicons" },
      keys = {
         { "gt", ":NvimTreeToggle<CR>", desc = "Open and focus file tree" },
      },
      cmd = { "NvimTreeOpen", "NvimTreeToggle" },
      opts = {
         sort = {
            sorter = "case_sensitive",
         },
      },
   },
   {
      "nvim-lua/plenary.nvim",
      lazy = false,
      priority = 1000,
      name = "plenary",
   },
   {
      "google/vim-jsonnet",
   },
   {
      "peterzalewski/vim-surround",
      event = { "BufReadPost", "BufWritePost", "BufNewFile" },
   },
   {
      "numToStr/Comment.nvim",
      event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
      "echasnovski/mini.align",
      version = false,
      config = true,
   },
   {
      "axkirillov/hbac.nvim",
      config = true,
   },
   {
      "folke/flash.nvim",
      event = "VeryLazy",
      ---@type Flash.Config
      opts = {
         modes = {
            char = {
               enabled = false,
            },
         },
      },
      -- stylua: ignore
      keys = {
         { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
         { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
         { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
         { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
         { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
      },
   },
   {
      "akinsho/toggleterm.nvim",
      lazy = true,
      keys = {
         {
            [[<c-\>]],
            function()
               require("toggleterm").toggle()
            end,
            desc = "Toggle terminal",
            mode = "n",
         },
      },
      cmd = { "ToggleTerm" },
      opts = {
         open_mapping = [[<c-\>]],
         insert_mappings = false,
         shell = "zsh",
         direction = "float",
         float_opts = { border = "single" },
      },
   },
   {
      "AndrewRadev/dsf.vim",
      keys = {
         { "dsf", "<Plug>DsfDelete", noremap = true, desc = "Delete Surrounding Function" },
         { "csf", "<Plug>DsfChange", noremap = true, desc = "Change Surrounding Function" },
      },
   },
   {
      "echasnovski/mini.ai",
      lazy = true,
      event = { "BufReadPost", "BufWritePost", "BufNewFile" },
      version = false,
      dependencies = {
         "nvim-treesitter/nvim-treesitter-textobjects",
      },
      opts = function()
         local ai = require("mini.ai")
         return {
            custom_textobjects = {
               o = ai.gen_spec.treesitter({ -- code block
                  a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                  i = { "@block.inner", "@conditional.inner", "@loop.inner" },
               }),
               F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
               c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
               C = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.outer" }),
            },
         }
      end,
   },
   {
      "folke/trouble.nvim",
      lazy = true,
      cmd = "Trouble",
      opts = {},
      dependencies = { "devicons" },
      keys = {
         { "<leader>cd", "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<CR>", desc = "Toggle diagnostics" },
      },
   },
   {
      "stevearc/aerial.nvim",
      lazy = true,
      keys = {
         { "<leader>co", "<cmd>AerialToggle<CR>", desc = "Toggle code outline" },
      },
      opts = {
         attach_mode = "global",
         highlight_on_jump = false,
      },
   },
   {
      "RRethy/vim-illuminate",
      event = { "BufReadPost", "BufWritePost", "BufNewFile" },
      opts = {
         delay = 200,
         large_file_cutoff = 2000,
         large_file_overrides = {
            providers = { "lsp" },
         },
      },
      config = function(_, opts)
         require("illuminate").configure(opts)

         local function map(key, dir, buffer)
            vim.keymap.set("n", key, function()
               require("illuminate")["goto_" .. dir .. "_reference"](false)
            end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
         end

         map("]]", "next")
         map("[[", "prev")

         -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
         vim.api.nvim_create_autocmd("FileType", {
            callback = function()
               local buffer = vim.api.nvim_get_current_buf()
               map("]]", "next", buffer)
               map("[[", "prev", buffer)
            end,
         })
      end,
      keys = {
         { "]]", desc = "Next Reference" },
         { "[[", desc = "Prev Reference" },
      },
   },
   {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPost", "BufWritePost", "BufNewFile" },
      keys = {
         {
            "]h",
            function()
               require("gitsigns").nav_hunk("next")
            end,
            desc = "Next Git hunk",
         },
         {
            "[h",
            function()
               require("gitsigns").nav_hunk("prev")
            end,
            desc = "Previous Git hunk",
         },
         {
            "<leader>cb",
            function()
               require("gitsigns").toggle_current_line_blame()
            end,
            desc = "Toggle git blame",
         },
      },
      opts = {},
   },
   {
      "NeogitOrg/neogit",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "ibhagwan/fzf-lua",
      },
      keys = {
         {
            "<leader>cg",
            function()
               require("neogit").open()
            end,
            desc = "Open Neogit",
         },
      },
      ---@type NeogitConfig
      opts = {
         disable_signs = true,
         graph_style = "unicode",
      },
   },
   {
      "Bekaboo/deadcolumn.nvim",
      event = { "BufReadPost", "BufWritePost", "BufNewFile" },
   },
   {
      "rcarriga/nvim-notify",
      config = true,
   },
   {
      "stevearc/conform.nvim",
      dependencies = { "mason.nvim" },
      opts = {
         formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
         },
      },
      keys = {
         {
            "<leader>cf",
            function()
               require("conform").format({ async = true, lsp_fallback = true })
            end,
            desc = "Format buffer",
         },
      },
   },
   {
      "j-hui/fidget.nvim",
      event = "LspAttach",
      opts = {
         progress = {
            ignore_done_already = true,
         },
         notification = {
            window = {
               winblend = 0,
               border = "single",
            },
         },
      },
   },
   {
      "b0o/schemastore.nvim",
   },
   {
      "stevearc/oil.nvim",
      lazy = true,
      dependencies = { "devicons" },
      cmd = { "Oil" },
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
   },
   {
      "nvim-treesitter/nvim-treesitter-context",
      event = { "BufReadPost", "BufWritePost", "BufNewFile" },
      config = true,
   },
   {
      "nvimdev/dashboard-nvim",
      event = "VimEnter",
      config = function()
         require("dashboard").setup({
            theme = "hyper",
            config = {
               shortcut = {},
               change_to_vcs_root = true,
               project = {
                  action = "FzfLua files cwd=",
               },
               header = {
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
                  [[                                                                               ]],
               },
            },
         })
      end,
      dependencies = { { "devicons" } },
   },
   {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@module "snacks"
      ---@type snacks.Config
      opts = {
         dim = { enabled = true },
         input = { enabled = true },
         notifier = { enabled = true },
      },
   },
   {
      "Wansmer/treesj",
      lazy = true,
      dependencies = { "treesitter" },
      cmd = { "TSJJoin", "TSJSplit" },
      opts = {
         use_default_keymaps = false,
         max_join_length = 150,
      },
   },
   {
      "stevearc/quicker.nvim",
      event = "FileType qf",
      ---@module "quicker"
      ---@type quicker.SetupOptions
      opts = {},
      keys = {
         {
            "<leader>q",
            function()
               require("quicker").toggle({ focus = true })
            end,
            desc = "Toggle quickfix",
         },
      },
   },
}
