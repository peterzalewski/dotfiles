-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/petezalewski/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/petezalewski/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/petezalewski/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/petezalewski/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/petezalewski/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.snippets\frequire\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["aerial.nvim"] = {
    config = { "\27LJ\2\n≠\1\0\1\a\0\v\0\0196\1\0\0009\1\1\0019\1\2\1'\3\3\0'\4\4\0'\5\5\0005\6\6\0=\0\a\6B\1\5\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\4\b\0'\5\t\0005\6\n\0=\0\a\6B\1\5\1K\0\1\0\1\0\1\vsilent\2\24<cmd>AerialNext<CR>\6}\vbuffer\1\0\1\vsilent\2\24<cmd>AerialPrev<CR>\6{\6n\bset\vkeymap\bvimt\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\1K\0\1\0\14on_attach\1\0\2\22highlight_on_jump\1\16attach_mode\vglobal\0\nsetup\vaerial\frequire\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/aerial.nvim",
    url = "https://github.com/stevearc/aerial.nvim"
  },
  catppuccin = {
    config = { "\27LJ\2\n™\1\0\1\4\0\14\0\0185\1\3\0005\2\1\0009\3\0\0=\3\2\2=\2\4\0015\2\6\0009\3\5\0=\3\2\2=\2\a\0015\2\b\0009\3\5\0=\3\2\2=\2\t\0015\2\n\0006\3\v\0=\3\f\2=\2\r\1L\1\2\0\fMsgArea\abg\16inactive_bg\1\0\0\16LineNrBelow\1\0\0\16LineNrAbove\1\0\0\rsurface1\vLineNr\1\0\0\afg\1\0\0\14rosewaterè\2\1\0\5\0\15\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\2B\0\2\0016\0\f\0009\0\r\0009\0\14\0'\2\1\0B\0\2\1K\0\1\0\16colorscheme\bcmd\bvim\17integrations\1\0\4\vfidget\2\bcmp\2\vaerial\2\rnvimtree\2\17dim_inactive\1\0\2\fenabled\2\15percentage\4\0ÄÄ¿˛\3\24highlight_overrides\1\0\1\fflavour\vfrappe\vfrappe\1\0\0\0\nsetup\15catppuccin\frequire\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.cmp\frequire\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["codi.vim"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/codi.vim",
    url = "https://github.com/metakirby5/codi.vim"
  },
  ["deadcolumn.nvim"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/deadcolumn.nvim",
    url = "https://github.com/Bekaboo/deadcolumn.nvim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\nr\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\vwindow\1\0\1\nblend\3\0\ttext\1\0\0\1\0\1\fspinner\tdots\nsetup\vfidget\frequire\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["fzf-lua"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/fzf-lua",
    url = "https://github.com/ibhagwan/fzf-lua"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nº\6\0\0\n\0-\0W6\0\0\0'\2\1\0B\0\2\2'\2\2\0B\0\2\0026\1\0\0'\3\3\0B\1\2\0029\1\4\1'\3\2\0B\1\2\0029\2\5\0009\2\6\2+\3\0\0=\3\a\0029\2\5\0009\2\b\0026\3\n\0=\3\t\0029\2\v\0009\2\6\0029\3\f\1=\3\t\0029\2\v\0009\2\6\0029\3\14\1=\3\r\0029\2\v\0009\2\15\0026\3\16\0=\3\t\0029\2\v\0009\2\b\0026\3\16\0=\3\t\0026\2\0\0'\4\17\0B\2\2\0029\2\18\0025\4\23\0005\5\20\0005\6\19\0=\6\21\5=\0\22\5=\5\24\0045\5\30\0004\6\3\0005\a\25\0005\b\26\0006\t\n\0=\t\r\b=\b\27\a5\b\28\0=\b\29\a>\a\1\6=\6\31\0054\6\3\0005\a \0>\a\1\6=\6!\0054\6\3\0005\a\"\0>\a\1\6=\6#\0054\6\3\0005\a$\0005\b%\0=\b\29\a>\a\1\6=\6&\5=\5'\0045\5(\0004\6\0\0=\6#\0054\6\3\0005\a)\0005\b*\0=\b\29\a>\a\1\6=\6\31\0054\6\0\0=\6+\0054\6\0\0=\6!\5=\5,\4B\2\2\1K\0\1\0\22inactive_sections\14lualine_b\1\0\2\tleft\bÓÇ∂\nright\bÓÇ¥\1\2\1\0\rfilename\18right_padding\3\2\1\0\0\rsections\14lualine_z\1\0\1\nright\bÓÇ¥\1\2\0\0\rlocation\14lualine_x\1\2\0\0\rfiletype\14lualine_c\1\2\1\0\rfilename\tpath\3\3\14lualine_a\1\0\0\14separator\1\0\2\tleft\bÓÇ∂\nright\bÓÇ∞\ncolor\1\0\0\1\2\0\0\tmode\foptions\1\0\0\ntheme\23disabled_filetypes\1\0\0\1\5\0\0\vaerial\rNvimTree\fTrouble\rquickfix\nsetup\flualine\16inactive_bg\6b\tbase\afg\rlavender\rinactive\14active_bg\abg\6c\bgui\6a\vnormal\16get_palette\24catppuccin.palettes\vfrappe\29catppuccin.utils.lualine\frequire\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  neogen = {
    config = { "\27LJ\2\n±\1\0\0\6\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\5\0005\5\4\0=\5\6\4=\4\b\3=\3\t\2B\0\2\1K\0\1\0\14languages\vpython\1\0\0\rtemplate\1\0\0\1\0\1\26annotation_convention\treST\1\0\2\fenabled\2\19snippet_engine\fluasnip\nsetup\vneogen\frequire\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/neogen",
    url = "https://github.com/danymat/neogen"
  },
  ["no-neck-pain.nvim"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/no-neck-pain.nvim",
    url = "https://github.com/shortcuts/no-neck-pain.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\nŒ\1\0\0\t\0\f\1\0186\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\n\0004\4\3\0009\5\3\0009\5\4\0059\5\5\0059\5\6\0055\a\b\0005\b\a\0=\b\t\aB\5\2\0?\5\0\0=\4\v\3B\1\2\1K\0\1\0\fsources\1\0\0\15extra_args\1\0\0\1\3\0\0\r--config\".arc/linters/black/black.toml\twith\nblack\15formatting\rbuiltins\nsetup\fnull-ls\frequire\3ÄÄ¿ô\4\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.lspconfig\frequire\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nØ\1\0\0\6\0\n\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0009\0\4\0009\0\5\0005\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\tdesc\29Open and focus file tree\23:NvimTreeFocus<CR>\agt\1\2\0\0\6n\bset\vkeymap\bvim\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.treesitter\frequire\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["stylua.nvim"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/stylua.nvim",
    url = "https://github.com/wesleimp/stylua.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\ni\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0005\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\nremap\2\22<Plug>(EasyAlign)\aga\1\3\0\0\6n\6x\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-kitty"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/vim-kitty",
    url = "https://github.com/fladson/vim-kitty"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/peterzalewski/vim-surround"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\nó\1\0\0\4\0\n\0\0176\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0)\1,\1=\1\3\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\b\0005\3\a\0=\3\t\2B\0\2\1K\0\1\0\vwindow\1\0\0\1\0\1\vborder\vsingle\nsetup\14which-key\frequire\15timeoutlen\ftimeout\6o\bvim\0" },
    loaded = true,
    path = "/Users/petezalewski/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: cmp-nvim-lsp
time([[Config for cmp-nvim-lsp]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.cmp\frequire\0", "config", "cmp-nvim-lsp")
time([[Config for cmp-nvim-lsp]], false)
-- Config for: aerial.nvim
time([[Config for aerial.nvim]], true)
try_loadstring("\27LJ\2\n≠\1\0\1\a\0\v\0\0196\1\0\0009\1\1\0019\1\2\1'\3\3\0'\4\4\0'\5\5\0005\6\6\0=\0\a\6B\1\5\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\4\b\0'\5\t\0005\6\n\0=\0\a\6B\1\5\1K\0\1\0\1\0\1\vsilent\2\24<cmd>AerialNext<CR>\6}\vbuffer\1\0\1\vsilent\2\24<cmd>AerialPrev<CR>\6{\6n\bset\vkeymap\bvimt\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\1K\0\1\0\14on_attach\1\0\2\22highlight_on_jump\1\16attach_mode\vglobal\0\nsetup\vaerial\frequire\0", "config", "aerial.nvim")
time([[Config for aerial.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\nr\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\vwindow\1\0\1\nblend\3\0\ttext\1\0\0\1\0\1\fspinner\tdots\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: vim-easy-align
time([[Config for vim-easy-align]], true)
try_loadstring("\27LJ\2\ni\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0005\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\nremap\2\22<Plug>(EasyAlign)\aga\1\3\0\0\6n\6x\bset\vkeymap\bvim\0", "config", "vim-easy-align")
time([[Config for vim-easy-align]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\nó\1\0\0\4\0\n\0\0176\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0)\1,\1=\1\3\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\b\0005\3\a\0=\3\t\2B\0\2\1K\0\1\0\vwindow\1\0\0\1\0\1\vborder\vsingle\nsetup\14which-key\frequire\15timeoutlen\ftimeout\6o\bvim\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.lspconfig\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nØ\1\0\0\6\0\n\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0009\0\4\0009\0\5\0005\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\tdesc\29Open and focus file tree\23:NvimTreeFocus<CR>\agt\1\2\0\0\6n\bset\vkeymap\bvim\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: neogen
time([[Config for neogen]], true)
try_loadstring("\27LJ\2\n±\1\0\0\6\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\5\0005\5\4\0=\5\6\4=\4\b\3=\3\t\2B\0\2\1K\0\1\0\14languages\vpython\1\0\0\rtemplate\1\0\0\1\0\1\26annotation_convention\treST\1\0\2\fenabled\2\19snippet_engine\fluasnip\nsetup\vneogen\frequire\0", "config", "neogen")
time([[Config for neogen]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nº\6\0\0\n\0-\0W6\0\0\0'\2\1\0B\0\2\2'\2\2\0B\0\2\0026\1\0\0'\3\3\0B\1\2\0029\1\4\1'\3\2\0B\1\2\0029\2\5\0009\2\6\2+\3\0\0=\3\a\0029\2\5\0009\2\b\0026\3\n\0=\3\t\0029\2\v\0009\2\6\0029\3\f\1=\3\t\0029\2\v\0009\2\6\0029\3\14\1=\3\r\0029\2\v\0009\2\15\0026\3\16\0=\3\t\0029\2\v\0009\2\b\0026\3\16\0=\3\t\0026\2\0\0'\4\17\0B\2\2\0029\2\18\0025\4\23\0005\5\20\0005\6\19\0=\6\21\5=\0\22\5=\5\24\0045\5\30\0004\6\3\0005\a\25\0005\b\26\0006\t\n\0=\t\r\b=\b\27\a5\b\28\0=\b\29\a>\a\1\6=\6\31\0054\6\3\0005\a \0>\a\1\6=\6!\0054\6\3\0005\a\"\0>\a\1\6=\6#\0054\6\3\0005\a$\0005\b%\0=\b\29\a>\a\1\6=\6&\5=\5'\0045\5(\0004\6\0\0=\6#\0054\6\3\0005\a)\0005\b*\0=\b\29\a>\a\1\6=\6\31\0054\6\0\0=\6+\0054\6\0\0=\6!\5=\5,\4B\2\2\1K\0\1\0\22inactive_sections\14lualine_b\1\0\2\tleft\bÓÇ∂\nright\bÓÇ¥\1\2\1\0\rfilename\18right_padding\3\2\1\0\0\rsections\14lualine_z\1\0\1\nright\bÓÇ¥\1\2\0\0\rlocation\14lualine_x\1\2\0\0\rfiletype\14lualine_c\1\2\1\0\rfilename\tpath\3\3\14lualine_a\1\0\0\14separator\1\0\2\tleft\bÓÇ∂\nright\bÓÇ∞\ncolor\1\0\0\1\2\0\0\tmode\foptions\1\0\0\ntheme\23disabled_filetypes\1\0\0\1\5\0\0\vaerial\rNvimTree\fTrouble\rquickfix\nsetup\flualine\16inactive_bg\6b\tbase\afg\rlavender\rinactive\14active_bg\abg\6c\bgui\6a\vnormal\16get_palette\24catppuccin.palettes\vfrappe\29catppuccin.utils.lualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.snippets\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: catppuccin
time([[Config for catppuccin]], true)
try_loadstring("\27LJ\2\n™\1\0\1\4\0\14\0\0185\1\3\0005\2\1\0009\3\0\0=\3\2\2=\2\4\0015\2\6\0009\3\5\0=\3\2\2=\2\a\0015\2\b\0009\3\5\0=\3\2\2=\2\t\0015\2\n\0006\3\v\0=\3\f\2=\2\r\1L\1\2\0\fMsgArea\abg\16inactive_bg\1\0\0\16LineNrBelow\1\0\0\16LineNrAbove\1\0\0\rsurface1\vLineNr\1\0\0\afg\1\0\0\14rosewaterè\2\1\0\5\0\15\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\2B\0\2\0016\0\f\0009\0\r\0009\0\14\0'\2\1\0B\0\2\1K\0\1\0\16colorscheme\bcmd\bvim\17integrations\1\0\4\vfidget\2\bcmp\2\vaerial\2\rnvimtree\2\17dim_inactive\1\0\2\fenabled\2\15percentage\4\0ÄÄ¿˛\3\24highlight_overrides\1\0\1\fflavour\vfrappe\vfrappe\1\0\0\0\nsetup\15catppuccin\frequire\0", "config", "catppuccin")
time([[Config for catppuccin]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\nŒ\1\0\0\t\0\f\1\0186\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\n\0004\4\3\0009\5\3\0009\5\4\0059\5\5\0059\5\6\0055\a\b\0005\b\a\0=\b\t\aB\5\2\0?\5\0\0=\4\v\3B\1\2\1K\0\1\0\fsources\1\0\0\15extra_args\1\0\0\1\3\0\0\r--config\".arc/linters/black/black.toml\twith\nblack\15formatting\rbuiltins\nsetup\fnull-ls\frequire\3ÄÄ¿ô\4\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
