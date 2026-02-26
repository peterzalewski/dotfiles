local theme = require("theme")
local active_bg = theme.active_bg
local inactive_bg = theme.inactive_bg

return {
   {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      dependencies = { "devicons", "catppuccin" },
      opts = function()
         local theme = require("catppuccin.utils.lualine")("frappe")
         local colors = require("catppuccin.palettes").get_palette("frappe")
         theme.normal.a.gui = nil
         theme.normal.b.bg = "#414559"
         theme.normal.c.bg = active_bg
         theme.normal.y = { bg = "#414559", fg = colors.subtext0 }
         theme.normal.z = { bg = theme.normal.a.bg, fg = active_bg, gui = "bold" }
         theme.inactive.a.bg = colors.lavender
         theme.inactive.a.fg = colors.base
         theme.inactive.b.bg = inactive_bg
         theme.inactive.b.fg = colors.subtext0
         theme.inactive.c.bg = inactive_bg
         theme.inactive.c.fg = colors.subtext0
         theme.inactive.y = { bg = inactive_bg, fg = colors.subtext0 }
         theme.inactive.z = { bg = inactive_bg, fg = colors.subtext0 }

         return {
            options = {
               disabled_filetypes = {
                  "no-neck-pain",
                  "snacks_dashboard",
                  "aerial",
                  "NvimTree",
                  "Trouble",
                  "quickfix",
                  "OverseerList",
                  "snacks_terminal",
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
               lualine_b = { "branch", "diagnostics", "lsp_status" },
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
}
