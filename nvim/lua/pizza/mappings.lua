local active_bg = "#303446"

-- Navigation
vim.keymap.set("n", "]b", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "[b", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "]q", ":cnext<CR>", { silent = true, desc = "Next quickfix item" })
vim.keymap.set("n", "[q", ":cprevious<CR>", { silent = true, desc = "Previous quickfix item" })
vim.keymap.set("n", "]z", "zj", { remap = true, desc = "Next fold" })
vim.keymap.set("n", "[z", "zk", { remap = true, desc = "Previous fold" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic item" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic item" })

-- Disable arrow key navigation in insert mode
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")

-- But use them to resize splits in normal mode
vim.keymap.set("n", "<up>", "<Cmd>resize +10<CR>", { silent = true, desc = "Increase window height" })
vim.keymap.set("n", "<down>", "<Cmd>resize -10<CR>", { silent = true, desc = "Decrease window height" })
vim.keymap.set("n", "<right>", "<Cmd>vertical resize +10<CR>", { silent = true, desc = "Increase window width" })
vim.keymap.set("n", "<left>", "<Cmd>vertical resize -10<CR>", { silent = true, desc = "Decrease window width" })
vim.keymap.set("n", "<S-up>", "<Cmd>resize +1<CR>", { silent = true, desc = "Increase window height" })
vim.keymap.set("n", "<S-down>", "<Cmd>resize -1<CR>", { silent = true, desc = "Decrease window height" })
vim.keymap.set("n", "<S-right>", "<Cmd>vertical resize +1<CR>", { silent = true, desc = "Increase window width" })
vim.keymap.set("n", "<S-left>", "<Cmd>vertical resize -1<CR>", { silent = true, desc = "Decrease window width" })

vim.keymap.set("n", "[<space>", "O<esc>j", { silent = true, desc = "Insert a blank line above" })
vim.keymap.set("n", "]<space>", "o<esc>k", { silent = true, desc = "Insert a blank line below" })

-- 'n' should always search forward and 'N' backward
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>nz", "<cmd>Lazy<cr>", { desc = "Lazy" })

return {
   "folke/which-key.nvim",
   event = "VeryLazy",
   opts = {
      notify = false,
      defaults = {
         { "<leader>c", group = "code", icon = { icon = " ", color = "orange" } },
         { "<leader>d", group = "debug" },
         { "<leader>f", group = "fuzzy find", icon = { icon = " ", color = "green" } },
         { "<leader>g", group = "grep", icon = { icon = "󱡠 ", color = "red" } },
         { "<leader>n", group = "neovim", icon = { icon = " ", color = "cyan" } },
      },
      sort = { "alphanum" },
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

      wk.add({
         { "<leader>h",       "<C-w>s<C-w>j", mode = "n", desc = "Split below",        icon = { icon = "" } },
         { "<leader>v",       "<C-w>v<C-w>l", mode = "n", desc = "Split right",        icon = { icon = "" } },
         { "<leader><space>", "za",           mode = "n", desc = "Open fold",          icon = { icon = "" } },
         { "<c-h>",           "<C-w>h",       mode = "n", desc = "Navigate pane left"  },
         { "<c-j>",           "<C-w>j",       mode = "n", desc = "Navigate pane down"  },
         { "<c-k>",           "<C-w>k",       mode = "n", desc = "Navigate pane up"    },
         { "<c-l>",           "<C-w>l",       mode = "n", desc = "Navigate pane right" },
      })

      wk.add(opts.defaults)
   end,
}
