local autogrp = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local theme = require("theme")
local active_bg = theme.active_bg
local inactive_bg = theme.inactive_bg
local accent = theme.accent
local general = autogrp("General Settings", { clear = true })

autocmd("FocusLost", {
   group = general,
   callback = function()
      vim.api.nvim_set_hl(0, "Normal", { fg = "#c6d0f5", bg = inactive_bg })
      vim.api.nvim_set_hl(0, "lualine_c_normal", { fg = "#c6d0f5", bg = inactive_bg })
   end,
})

autocmd("FocusGained", {
   group = general,
   callback = function()
      vim.api.nvim_set_hl(0, "Normal", { fg = "#c6d0f5", bg = active_bg })
      vim.api.nvim_set_hl(0, "lualine_c_normal", { fg = "#c6d0f5", bg = active_bg })
   end,
})

autocmd("TextYankPost", {
   group = general,
   pattern = { "*" },
   callback = function()
      vim.hl.on_yank({ higroup = "IncSearch", timeout = 700 })
   end,
})

return {
   {
      "catppuccin/nvim",
      name = "catppuccin",
      lazy = false,
      priority = 1000,
      opts = {
         highlight_overrides = {
            frappe = function(colors)
               return {
                  -- Editor
                  LineNr = { fg = colors.rosewater },
                  LineNrAbove = { fg = colors.surface1 },
                  LineNrBelow = { fg = colors.surface1 },
                  NormalNC = { bg = inactive_bg },
                  StatusLine = { bg = active_bg },
                  StatusLineNC = { bg = inactive_bg, fg = inactive_bg },
                  TabLineFill = { bg = active_bg },
                  MsgArea = { bg = active_bg },
                  WinSeparator = { fg = inactive_bg, bg = inactive_bg },

                  -- Fidget
                  FidgetTitle = { fg = "#f2d5cf", bg = active_bg },
                  FidgetTask = { fg = "#f2d5cf", bg = active_bg },

                  -- NvimTree
                  NvimTreeNormal = { bg = active_bg },
                  NvimTreeNormalNC = { bg = inactive_bg },
                  NvimTreeEndOfBuffer = { fg = active_bg },
                  NvimTreeStatusLine = { bg = active_bg, fg = active_bg },
                  NvimTreeStatusLineNC = { bg = inactive_bg, fg = inactive_bg },
                  NvimTreeCursorLine = { bg = accent },
                  NvimTreeWindowPicker = { fg = "#ededed", bg = accent, bold = true },
                  NvimTreeWinSeparator = { fg = inactive_bg, bg = inactive_bg },
                  NvimTreeSignColumn = { bg = inactive_bg },
                  NvimTreeHarpoonIcon = { fg = colors.peach, bold = true },
                  NvimTreeHarpoonFile = { fg = colors.peach },

                  -- Claude Code terminal
                  ClaudeTermNormal = { bg = active_bg },
                  ClaudeTermNormalNC = { bg = inactive_bg },
                  ClaudeTermStatusLine = { bg = active_bg, fg = active_bg },
                  ClaudeTermStatusLineNC = { bg = inactive_bg, fg = inactive_bg },
               }
            end,
         },
         flavour = "frappe",
         integrations = {
            aerial = true,
            fidget = true,
            gitsigns = true,
            mason = true,
            nvimtree = true,
            treesitter = true,
            which_key = true,

            native_lsp = {
               enabled = true,
               underlines = {
                  errors = { "undercurl" },
                  hints = { "undercurl" },
                  warnings = { "undercurl" },
                  information = { "undercurl" },
               },
            },
         },
      },
      config = function(_, opts)
         require("catppuccin").setup(opts)
         vim.cmd.colorscheme("catppuccin")
      end,
   },
}
