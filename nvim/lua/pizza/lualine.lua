local active_bg = "#303446"
local inactive_bg = "#2B2E3F"

return {
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
