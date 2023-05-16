vim.g.mapleader = ","

-- Open a fold
vim.keymap.set('n', '<leader><space>', 'za', { remap = true })
-- Move between folds
vim.keymap.set('n', '{', 'zk', { remap = true })
vim.keymap.set('n', '}', 'zj', { remap = true })

-- Open vertical split to the right
vim.keymap.set('n', '<leader>v', '<C-w>v<C-w>l')
-- Open horizontal split below
vim.keymap.set('n', '<leader>h', '<C-w>s<C-w>j')

-- Fuzzy find files from the project root
vim.keymap.set('n', '<leader>t', "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
-- Fuzzy find open buffers
vim.keymap.set('n', '<leader>b', "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
-- Fuzzy find register contents
vim.keymap.set('n', '<leader>r', "<cmd>lua require('fzf-lua').registers()<CR>", { silent = true })
-- Move back and forth between buffers
vim.keymap.set('n', ']b', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '[b', ':bprevious<CR>', { silent = true })
-- Jump around the quickfix list
vim.keymap.set('n', ']q', ':cnext<CR>', { silent = true })

-- Disable arrow key navigation to impressive... who?
vim.keymap.set({'n', 'i'}, '<up>', '<nop>')
vim.keymap.set({'n', 'i'}, '<down>', '<nop>')
vim.keymap.set({'n', 'i'}, '<left>', '<nop>')
vim.keymap.set({'n', 'i'}, '<right>', '<nop>')

-- Insert a blank line above or below the current
vim.keymap.set({'n'}, '[<space>', 'O<esc>j')
vim.keymap.set({'n'}, ']<space>', 'o<esc>k', { silent = true })

-- Jump up and down through errors/lint warnings
vim.keymap.set({'n'}, ']e', "<cmd>lua vim.diagnostic.goto_next()<CR>", { silent = true })
vim.keymap.set({'n'}, '[e', "<cmd>lua vim.diagnostic.goto_prev()<CR>", { silent = true })
