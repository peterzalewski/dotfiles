local theme = require("theme")
local active_bg = theme.active_bg
local inactive_bg = theme.inactive_bg

return {
   {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      dependencies = { "devicons", "catppuccin" },
      config = function(_, opts)
         local lualine = require("lualine")
         local colors = require("catppuccin.palettes").get_palette("frappe")
         local lualine_theme = require("catppuccin.utils.lualine")("frappe")

         local tabline_config = {
            lualine_a = {
               {
                  "tabs",
                  mode = 2,
                  max_length = vim.o.columns,
                  separator = { left = "", right = "" },
                  color = { fg = active_bg },
                  tabs_color = {
                     active = { bg = lualine_theme.normal.a.bg, fg = active_bg, gui = "bold" },
                     inactive = { bg = "#414559", fg = colors.subtext0 },
                  },
               },
            },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
         }

         opts.tabline = tabline_config
         lualine.setup(opts)
         vim.o.showtabline = 0

         local function toggle_tabline()
            local tabs = vim.fn.tabpagenr("$")
            vim.o.showtabline = tabs > 1 and 2 or 0
         end

         vim.api.nvim_create_autocmd("TabNew", {
            group = vim.api.nvim_create_augroup("pizza: Show tabline", { clear = true }),
            callback = toggle_tabline,
         })
         vim.api.nvim_create_autocmd("TabClosed", {
            group = vim.api.nvim_create_augroup("pizza: Hide tabline", { clear = true }),
            callback = function()
               vim.schedule(toggle_tabline)
            end,
         })
      end,
      opts = function()
         local ll_theme = require("catppuccin.utils.lualine")("frappe")
         local colors = require("catppuccin.palettes").get_palette("frappe")
         ll_theme.normal.a.gui = nil
         ll_theme.normal.b.bg = "#414559"
         ll_theme.normal.c.bg = active_bg
         ll_theme.normal.y = { bg = "#414559", fg = colors.subtext0 }
         ll_theme.normal.z = { bg = ll_theme.normal.a.bg, fg = active_bg, gui = "bold" }
         ll_theme.inactive.a.bg = colors.lavender
         ll_theme.inactive.a.fg = colors.base
         ll_theme.inactive.b.bg = inactive_bg
         ll_theme.inactive.b.fg = colors.subtext0
         ll_theme.inactive.c.bg = inactive_bg
         ll_theme.inactive.c.fg = colors.subtext0
         ll_theme.inactive.y = { bg = inactive_bg, fg = colors.subtext0 }
         ll_theme.inactive.z = { bg = inactive_bg, fg = colors.subtext0 }

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
               theme = ll_theme,
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