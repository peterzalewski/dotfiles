return {
   {
      "nvim-treesitter/nvim-treesitter",
      name = "treesitter",
      build = ":TSUpdate",
      version = false,
      lazy = false,
      opts = {
         context_commentstring = { enable = true },
         incremental_selection = {
            enable = true,
            keymaps = {
               init_selection = "<Space><Space>",
               node_incremental = "<Space>",
               scope_incremental = "<Tab>",
               node_decremental = "<C-Space>",
            },
         },
         ensure_installed = {
            "bash",
            "go",
            "html",
            "json",
            "lua",
            "rust",
            "python",
            "yaml",
         },
      },
      config = function(_, opts)
         require("nvim-treesitter.configs").setup(opts)

         vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
               pcall(vim.treesitter.start, args.buf)
            end,
         })
      end,
   },
}
