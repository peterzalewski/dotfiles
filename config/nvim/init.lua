require('plugins')
require('bindings')

require('catppuccin').setup({
    flavour = 'frappe',
})

require('lualine').setup({})

vim.cmd.colorscheme 'catppuccin'
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.backspace = { 'eol', 'indent', 'start' }
vim.opt.backup = false
vim.opt.clipboard = 'unnamed'
vim.opt.expandtab = true
vim.opt.fileformats = { 'unix', 'mac', 'dos' }
vim.opt.fillchars = { vert = '│' }
vim.opt.foldlevelstart = 20
vim.opt.formatoptions = 'qcj'
vim.opt.gdefault = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.joinspaces = false
vim.opt.laststatus = 2
vim.opt.modelines = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.scrolloff = 2
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.showmode = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.startofline = false
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.ttyfast = true
vim.opt.wildignore:append({ '.git', 'node_modules' })
vim.opt.wildmenu = true
-- vim.opt.wildmode = { list = { 'full', 'longest' } }
vim.opt.writebackup = false
vim.wo.signcolumn = "yes"

require('neodev').setup({})
require('rust-tools').setup({})
local border = {
    { "╭", "CmpBorder" },
    { "─", "CmpBorder" },
    { "╮", "CmpBorder" },
    { "│", "CmpBorder" },
    { "╯", "CmpBorder" },
    { "─", "CmpBorder" },
    { "╰", "CmpBorder" },
    { "│", "CmpBorder" },
}

local ls = require('luasnip')
local s = ls.snippet
ls.add_snippets('all', {
  s('nvimmap', { ls.text_node("vim.keymap.set){'")}),
})

local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Insert,
    }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }),
  window = {
    documentation = {
      border = border,
    },
    completion = {
      border = border,
    },
  }
})
-- Tab when there's only one match left also completes
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({})
lspconfig.pylsp.setup({
  cmd = { 'pylsp-3.11' },
})

vim.diagnostic.config({
  float = { border = "rounded" },
})

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    module_path = 'nvim-treesitter.textobjects',
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn", -- set to `false` to disable one of the mappings
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  ensure_installed = {
    'lua',
    'rust',
    'python',
  },
})
