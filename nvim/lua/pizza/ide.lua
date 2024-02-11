return {
   { "fladson/vim-kitty" },
   { "google/vim-jsonnet" },
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
      "mfussenegger/nvim-dap",
      dependencies = {
         {
            "rcarriga/nvim-dap-ui",
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
        },
            opts = {},
            config = function(_, opts)
               local dap = require("dap")
               local dapui = require("dapui")
               dapui.setup(opts)
               dap.listeners.after.event_initialized["dapui_config"] = function()
                  dapui.open({})
               end
               dap.listeners.before.event_terminated["dapui_config"] = function()
                  dapui.close({})
               end
               dap.listeners.before.event_exited["dapui_config"] = function()
                  dapui.close({})
               end
            end,
         },
      },
      keys = {
         {
            "<leader>dB",
            function()
               require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end,
            desc = "Breakpoint Condition",
         },
         {
            "<leader>db",
            function()
               require("dap").toggle_breakpoint()
            end,
            desc = "Toggle Breakpoint",
         },
         {
            "<leader>dc",
            function()
               require("dap").continue()
            end,
            desc = "Continue",
         },
         {
            "<leader>da",
            function()
               require("dap").continue({ before = get_args })
            end,
            desc = "Run with Args",
         },
         {
            "<leader>dC",
            function()
               require("dap").run_to_cursor()
            end,
            desc = "Run to Cursor",
         },
         {
            "<leader>dg",
            function()
               require("dap").goto_()
            end,
            desc = "Go to line (no execute)",
         },
         {
            "<leader>di",
            function()
               require("dap").step_into()
            end,
            desc = "Step Into",
         },
         {
            "<leader>dj",
            function()
               require("dap").down()
            end,
            desc = "Down",
         },
         {
            "<leader>dk",
            function()
               require("dap").up()
            end,
            desc = "Up",
         },
         {
            "<leader>dl",
            function()
               require("dap").run_last()
            end,
            desc = "Run Last",
         },
         {
            "<leader>do",
            function()
               require("dap").step_out()
            end,
            desc = "Step Out",
         },
         {
            "<leader>dO",
            function()
               require("dap").step_over()
            end,
            desc = "Step Over",
         },
         {
            "<leader>dp",
            function()
               require("dap").pause()
            end,
            desc = "Pause",
         },
         {
            "<leader>dr",
            function()
               require("dap").repl.toggle()
            end,
            desc = "Toggle REPL",
         },
         {
            "<leader>ds",
            function()
               require("dap").session()
            end,
            desc = "Session",
         },
         {
            "<leader>dt",
            function()
               require("dap").terminate()
            end,
            desc = "Terminate",
         },
         {
            "<leader>dw",
            function()
               require("dap.ui.widgets").hover()
            end,
            desc = "Widgets",
         },
      },
      config = false,
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
            "]g",
            function()
               require("gitsigns").next_hunk()
            end,
         },
         {
            "[g",
            function()
               require("gitsigns").prev_hunk()
            end,
         },
      },
      opts = {},
   },
   {
      "echasnovski/mini.indentscope",
      event = { "BufReadPost", "BufNewFile", "BufWritePre" },
      opts = {},
   },
}
