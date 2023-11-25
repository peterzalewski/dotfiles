vim.g.mapleader = ","

vim.keymap.set("n", "<leader><space>", "za", { remap = true, desc = "Open a fold" })
vim.keymap.set("n", "<leader>v", "<C-w>v<C-w>l", { desc = "Open vertical split to the right" })
vim.keymap.set("n", "<leader>h", "<C-w>s<C-w>j", { desc = "Open horizontal split below" })

-- Fuzzy find
vim.keymap.set("n", "<leader>t", function()
	require("fzf-lua").files()
end, { desc = "Fuzzy find files" })
vim.keymap.set("n", "<leader>b", function()
	require("fzf-lua").buffers()
end, { desc = "Fuzzy find open buffers" })
vim.keymap.set("n", "<leader>r", function()
	require("fzf-lua").registers()
end, { desc = "Fuzzy find register contents" })
vim.keymap.set("n", "<leader>k", function()
	require("fzf-lua").help_tags()
end, { desc = "Fuzzy find keywords in Neovim help" })
vim.keymap.set("n", "<leader>K", function()
	require("fzf-lua").keymaps()
end, { desc = "Fuzzy find keymaps" })
vim.keymap.set("n", "<leader>g", function()
	require("fzf-lua").live_grep_native()
end, { desc = "Live grep through the current project" })
vim.keymap.set("n", "<leader>G", function()
	require("fzf-lua").grep_cword()
end, { desc = "Live grep for the current word" })
vim.keymap.set("n", "<leader>s", function()
	require("fzf-lua").fzf_exec(require("persisted").list)
end, { desc = "Search for sessions" })
vim.keymap.set("i", "<C-r>", function()
	require("fzf-lua").registers()
end, { desc = "Fuzzy find register contents" })
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { silent = true, desc = "Open the Aerial window" })
vim.keymap.set("n", "<leader>d", ":TroubleToggle<CR>", { silent = true, desc = "Open diagnostics" })

-- Navigation
vim.keymap.set("n", "]b", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "[b", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "]q", ":cnext<CR>", { silent = true, desc = "Next quickfix item" })
vim.keymap.set("n", "[q", ":cprevious<CR>", { silent = true, desc = "Previous quickfix item" })
vim.keymap.set("n", "]z", "zj", { remap = true, desc = "Next fold" })
vim.keymap.set("n", "[z", "zk", { remap = true, desc = "Previous fold" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic item" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic item" })

-- Disable arrow key navigation to impress... who?
vim.keymap.set({ "n", "i" }, "<up>", "<nop>")
vim.keymap.set({ "n", "i" }, "<down>", "<nop>")
vim.keymap.set({ "n", "i" }, "<left>", "<nop>")
vim.keymap.set({ "n", "i" }, "<right>", "<nop>")

vim.keymap.set("n", "[<space>", "O<esc>j", { silent = true, desc = "Insert a blank line above" })
vim.keymap.set("n", "]<space>", "o<esc>k", { silent = true, desc = "Insert a blank line below" })

-- 'n' should always search forward and 'N' backward
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })

vim.keymap.set("i", "<C-g>", function()
	require("Comment.api").toggle.linewise()
end, { desc = "Comment line while insert", silent = true })
vim.keymap.set("n", "<leader>nf", function()
	require("neogen").generate()
end, { desc = "Manage annotation" })

vim.keymap.set("n", "Q", "<nop>")
