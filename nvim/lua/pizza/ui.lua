local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local active_bg = "#303446"
local inactive_bg = "#2B2E3F"

autocmd("CmdLineLeave", {
   group = augroup("CmdLineFader", { clear = true }),
   callback = function()
      vim.fn.timer_start(5000, function()
         vim.cmd([[ echon ' ' ]])
      end)
   end,
})

autocmd("FileType", {
   group = augroup("ExitShortcut", { clear = true }),
   pattern = {
      "PlenaryTestPopup",
      "fugitiveblame",
      "help",
      "httpResult",
      "lspinfo",
      "notify",
      "qf",
      "spectre_panel",
      "startuptime",
      "tsplayground",
   },
   callback = function(event)
      vim.bo[event.buf].buflisted = false
		-- stylua: ignore
		vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true })
   end,
})

vim.fn.sign_define(
   "DiagnosticSignInfo",
   { text = "", numhl = "DiagnosticInformation", texthl = "DiagnosticInformation" }
)
vim.fn.sign_define("DiagnosticSignWarn", { text = "⚠", numhl = "DiagnosticWarn", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DiagnosticSignError", {
   text = "",
   numhl = "DiagnosticError",
   texthl = "DiagnosticError",
})
vim.fn.sign_define("DiagnosticSignHint", {
   text = "",
   numhl = "DiagnosticHint",
   texthl = "DiagnosticHint",
})

return {
   { "nvim-tree/nvim-web-devicons", name = "devicons" },
   {
      "nvim-tree/nvim-tree.lua",
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
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      dependencies = { "devicons", "catppuccin" },
      opts = function()
         local theme = require("catppuccin.utils.lualine")("frappe")
         local colors = require("catppuccin.palettes").get_palette("frappe")
         theme.normal.a.gui = nil
         theme.normal.c.bg = active_bg
         theme.inactive.a.bg = colors.lavender
         theme.inactive.a.fg = colors.base
         theme.inactive.b.bg = inactive_bg
         theme.inactive.c.bg = inactive_bg

         return {
            options = {
               disabled_filetypes = {
                  "no-neck-pain",
                  "dashboard",
                  "aerial",
                  "NvimTree",
                  "Trouble",
                  "quickfix",
                  "OverseerList",
                  "toggleterm",
                  "qf",
               },
               ignore_focus = {
                  "dapui_scopes",
                  "dapui_breakpoints",
                  "dapui_stacks",
                  "dapui_watches",
                  "dap-repl",
                  "dapui_console",
                  "help",
               },
               theme = theme,
               refresh = {
                  -- Is this too low?
                  statusline = 100,
                  tabline = 1000,
                  winbar = 1000,
               },
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
               lualine_b = { "branch", "diagnostics" },
               lualine_c = { { "filename", path = 3 } },
               lualine_x = {
                  {
                     "filetype",
                     "overseer",
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
                     file_status = false,
                  },
               },
               lualine_b = {},
               lualine_c = {},
            },
         }
      end,
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
   { "Bekaboo/deadcolumn.nvim" },
   { "shortcuts/no-neck-pain.nvim" },
   { "rcarriga/nvim-notify", opts = {} },
}
