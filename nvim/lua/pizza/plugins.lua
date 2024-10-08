local active_bg = "#303446"
local inactive_bg = "#2B2E3F"

return {
   {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
         library = {
            { path = "luvit-meta/library", words = { "vim%.uv" } },
         },
      },
   },
   {
      "williamboman/mason.nvim",
      cmd = "Mason",
      build = ":MasonUpdate",
      keys = {
         { "<leader>nm", "<cmd>Mason<cr>", desc = "Mason" },
      },
      ---@class MasonSettings
      opts = {
         pip = {
            upgrade_pip = true,
         },
         ui = {
            border = "single",
         },
      },
   },
   { "nvim-tree/nvim-web-devicons", name = "devicons" },
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
   { "nvim-lua/plenary.nvim", lazy = false, priority = 1000, name = "plenary" },
   { "christoomey/vim-tmux-navigator" },
   { "fladson/vim-kitty" },
   { "google/vim-jsonnet" },
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
      version = "*",
      keys = {
         {
            "<C-Space>",
            function()
               require("toggleterm").toggle()
            end,
            desc = "Toggle terminal",
         },
      },
      cmd = { "ToggleTerm" },
      opts = {
         open_mapping = "<C-Space>",
         direction = "float",
         shell = "zsh",
         float_opts = { border = "single" },
      },
   },
   {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
         notify = false,
         defaults = {
            { "<leader>d", group = "debug" },
            { "<leader>f", group = "fuzzy find" },
            { "<leader>g", group = "grep", icon = { icon = " ", color = "red" } },
            { "<leader>n", group = "neovim", icon = { icon = " ", color = "cyan" } },
         },
         win = {
            border = "single",
         },
      },
      init = function()
         vim.o.timeout = true
         vim.o.timeoutlen = 300
         vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = active_bg })
      end,
      config = function(_, opts)
         local wk = require("which-key")
         wk.setup(opts)
         wk.add(opts.defaults)
      end,
   },
   { "L3MON4D3/LuaSnip", lazy = true, name = "luasnip", version = "v1.*", build = "make install_jsregexp" },
   {
      "danymat/neogen",
      event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
      "AndrewRadev/dsf.vim",
      keys = {
         { "dsf", "<Plug>DsfDelete", noremap = true, desc = "Delete Surrounding Function" },
         { "csf", "<Plug>DsfChange", noremap = true, desc = "Change Surrounding Function" },
      },
   },
   {
      "echasnovski/mini.ai",
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
      dependencies = { "devicons" },
      keys = {
         { "<leader>D", ":TroubleToggle<CR>", desc = "Open diagnostics" },
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
   {
      "RRethy/vim-illuminate",
      event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
      event = { "BufReadPost", "BufNewFile", "BufWritePre" },
      keys = {
         {
            "]h",
            function()
               require("gitsigns").next_hunk()
            end,
            desc = "Next Git hunk",
         },
         {
            "[h",
            function()
               require("gitsigns").prev_hunk()
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
   { "Bekaboo/deadcolumn.nvim" },
   { "shortcuts/no-neck-pain.nvim" },
   { "rcarriga/nvim-notify", config = true },
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
            "<leader>cF",
            function()
               require("conform").format({ async = true, lsp_fallback = true })
            end,
            desc = "Format buffer",
         },
      },
   },
   {
      "j-hui/fidget.nvim",
      lazy = true,
      name = "fidget",
      opts = {
         progress = {
            ignore_done_already = true,
         },
         notification = {
            window = {
               winblend = 0,
            },
         },
      },
   },
   {
      "b0o/schemastore.nvim",
   },
   {
      "stevearc/oil.nvim",
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      dependencies = { { "devicons" } },
   },
   {
      "nvim-treesitter/nvim-treesitter-context",
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
}