return {
   {
      "nvim-treesitter/nvim-treesitter",
      name = "treesitter",
      build = ":TSUpdate",
      version = false,
      event = { "BufReadPost", "BufNewFile" },
      opts = {
         highlight = {
            enable = true,
         },
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
      end,
   },
}
