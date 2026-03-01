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
      dependencies = { "devicons", "ThePrimeagen/harpoon" },
      keys = {
         { "<leader>e",
            function()
               local api = require("nvim-tree.api")
               local view = require("nvim-tree.view")

               if view.is_visible() then
                  api.tree.close()
                  return
               end -- Wide display: sidebar. Narrow: float.

               if vim.o.columns > 160 then
                  api.tree.open({ find_file = true })
               else
                  api.tree.open({ find_file = true, float = { enable = true } })
               end
            end,
            desc = "Toggle file tree (adaptive)",
         },
      },
      cmd = { "NvimTreeOpen", "NvimTreeToggle" },
      opts = function()
         local HarpoonDecorator = require("harpoon-tree")
         return {
            renderer = {
               decorators = {
                  "Git", "Open", "Hidden", "Modified", "Bookmark",
                  "Diagnostics", "Copied", "Cut",
                  HarpoonDecorator,
               },
            },
            sort = {
               sorter = "case_sensitive",
            },
         view = {
            width = 40,
            float = {
               enable = false, -- default off; the keymap enables it dynamically
               open_win_config = function()
                  local screen_w = vim.o.columns
                  local screen_h = vim.o.lines
                  local w = math.floor(screen_w * 0.5)
                  local h = math.floor(screen_h * 0.7)
                  return {
                     relative = "editor",
                     border = "single",
                     width = w,
                     height = h,
                     row = math.floor((screen_h - h) / 2),
                     col = math.floor((screen_w - w) / 2),
                  }
               end,
            },
         },
         update_focused_file = {
            enable = true,
         },
         on_attach = function(bufnr)
            require("nvim-tree.api").config.mappings.default_on_attach(bufnr)
            vim.schedule(function()
               local winid = vim.fn.bufwinid(bufnr)
               if winid ~= -1 then
                  vim.wo[winid].statusline = " "
               end
            end)

            local theme = require("theme")
            local grp = vim.api.nvim_create_augroup("pizza: NvimTree sign column", { clear = true })
            vim.api.nvim_create_autocmd("WinEnter", {
               group = grp,
               buffer = bufnr,
               callback = function()
                  vim.api.nvim_set_hl(0, "NvimTreeSignColumn", { bg = theme.active_bg })
               end,
            })
            vim.api.nvim_create_autocmd("WinLeave", {
               group = grp,
               buffer = bufnr,
               callback = function()
                  vim.api.nvim_set_hl(0, "NvimTreeSignColumn", { bg = theme.inactive_bg })
               end,
            })
         end,
      }
      end,
   },
   {
      "nvim-lua/plenary.nvim",
      lazy = true,
      name = "plenary",
   },
   {
      "google/vim-jsonnet",
   },
   {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      lazy = true,
      dependencies = { "plenary" },
      keys = {
         { "<leader>.", function() require("harpoon"):list():add() end, desc = "Harpoon file" },
         { "<leader>m", function() local h = require("harpoon") h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon menu" },
         { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
         { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
         { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
         { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },
      },
      config = function()
         local harpoon = require("harpoon")
         harpoon:setup()

         local function refresh_tree()
            local ok, api = pcall(require, "nvim-tree.api")
            if ok and api.tree.is_visible() then
               api.tree.reload()
            end
         end

         harpoon:extend({
            ADD = refresh_tree,
            REMOVE = refresh_tree,
            LIST_CHANGE = refresh_tree,
         })
      end,
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
         { "s",     mode = { "n" }, function() require("flash").jump() end,              desc = "Flash" },
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
      "Bekaboo/deadcolumn.nvim",
      event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
               require("conform").format({ async = true, lsp_format = "fallback" })
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
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@module "snacks"
      ---@type snacks.Config
      opts = {
         dim = { enabled = true },
         input = { enabled = true },
         notifier = { enabled = true },
         dashboard = {
            enabled = true,
            width = 80,
            preset = {
               pick = function (cmd, opts)
                  require("fzf-lua")[cmd](opts)
               end,
               header = table.concat({
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
               }, "\n"),
               keys = {
                  { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                  { icon = "󱡠 ", key = "g", desc = "Grep", action = ":lua Snacks.dashboard.pick('live_grep_native')" },
                  { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                  { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })" },
                  { icon = " ", key = "q", desc = "Quit", action = ":qa" },
               },
            },
            sections = {
               { section = "header" },
               { section = "keys", gap = 0, padding = 1 },
               { section = "startup" },
            },
         },
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
   {
      "norcalli/nvim-colorizer.lua",
      event = { "BufReadPost", "BufWritePost", "BufNewFile" },
      config = function()
         require("colorizer").setup()
      end,
   },
   {
      "coder/claudecode.nvim",
      dependencies = { "folke/snacks.nvim" },
      config = true,
      opts = {
         terminal = {
            split_side = "right",
            split_width_percentage = 0.35,
            provider = "snacks",
            git_repo_cwd = true,
            snacks_win_opts = {
               wo = {
                  number = false,
                  relativenumber = false,
               },
            },
         },
         diff_opts = {
            open_in_new_tab = true,
            hide_terminal_in_new_tab = true,
         },
      },
      keys = {
         { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
         { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
         { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
         { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
         { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
         { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
         { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
         {
            "<leader>as",
            "<cmd>ClaudeCodeTreeAdd<cr>",
            desc = "Add file from tree",
            ft = { "NvimTree" },
         },
      },
   },
   {
      "folke/todo-comments.nvim",
      event = { "BufReadPost", "BufWritePost", "BufNewFile" },
      dependencies = { "plenary" },
      opts = {},
      keys = {
         { "]x", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
         { "[x", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
         { "<leader>ft", "<cmd>TodoFzfLua<cr>", desc = "Fuzzy find todos" },
      },
   },
   {
      "sindrets/diffview.nvim",
      lazy = true,
      cmd = { "DiffviewOpen", "DiffviewFileHistory" },
      keys = {
         { "<leader>cv", "<cmd>DiffviewOpen<cr>", desc = "Open diff view" },
         { "<leader>ch", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      },
      opts = {},
   },
}
