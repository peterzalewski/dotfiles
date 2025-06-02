return {
   {
      "saghen/blink.cmp",
      event = { "InsertEnter", "CmdlineEnter" },
      dependencies = { "rafamadriz/friendly-snippets" },

      -- use a release tag to download pre-built binaries
      version = "1.*",
      -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',
      -- If you use nix, you can build from source using latest nightly rust with:
      -- build = 'nix run .#build-plugin',

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
         appearance = {
            nerd_font_variant = "mono",
         },

         completion = {
            documentation = {
               auto_show = true,
               window = {
                  border = "single",
               },
            },
            list = {
               selection = {
                  preselect = false,
               },
            },
            menu = {
               border = "single",
            },
         },

         sources = {
            default = { "lsp", "path", "snippets", "buffer" },
         },

         keymap = {
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "snippet_forward", "fallback" },
            ["<C-k>"] = { "select_prev", "snippet_backward", "fallback" },
            ["<C-h>"] = { "scroll_documentation_down", "fallback" },
            ["<C-l>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
         },

         cmdline = {
            completion = {
               list = {
                  selection = {
                     preselect = false,
                  },
               },
               menu = {
                  auto_show = true,
               },
            },
            -- Do not map <CR> to accept because I rely on decades of honed reflexes typing :wq
            keymap = {
               ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
               ["<C-e>"] = { "hide", "fallback" },
               ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
               ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
               ["<Down>"] = { "select_next", "fallback" },
               ["<Up>"] = { "select_prev", "fallback" },
               ["<C-j>"] = { "select_next", "snippet_forward", "fallback" },
               ["<C-k>"] = { "select_prev", "snippet_backward", "fallback" },
               ["<C-h>"] = { "scroll_documentation_down", "fallback" },
               ["<C-l>"] = { "scroll_documentation_up", "fallback" },
            },
            sources = function()
               local type = vim.fn.getcmdtype()
               if type == "/" or type == "?" then
                  return { "buffer" }
               else
                  return { "cmdline", "path" }
               end
            end,
         },

         -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
         -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
         -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
         --
         -- See the fuzzy documentation for more information
         fuzzy = { implementation = "prefer_rust_with_warning" },
      },
      opts_extend = { "sources.default" },
   },
}
