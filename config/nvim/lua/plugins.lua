return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {'catppuccin/nvim', as = 'catppuccin'}

  use 'folke/neodev.nvim'

  use 'peterzalewski/vim-surround'
  use 'tpope/vim-commentary'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use { 'ibhagwan/fzf-lua',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use 'christoomey/vim-tmux-navigator'
  use 'simrat39/rust-tools.nvim'
  use({
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    tag = 'v1.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!:).
    run = "make install_jsregexp"
  })
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
end)
