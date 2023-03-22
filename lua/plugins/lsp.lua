return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "ThePrimeagen/refactoring.nvim" },
    config = function()
      local nls = require("null-ls")
      nls.setup({
        debounce = 150,
        save_after_format = false,
        sources = {
          nls.builtins.code_actions.refactoring,
          nls.builtins.code_actions.gitsigns,
          nls.builtins.formatting.prettier.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "css",
              "scss",
              "less",
              "html",
              "json",
              "yaml",
              "markdown",
              "markdown.mdx",
              "graphql",
            },
          }),
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.fish_indent,
          nls.builtins.formatting.black,
          nls.builtins.formatting.xmlformat,
          nls.builtins.completion.spell.with({
            filetypes = {
              "markdown",
              "markdown.mdx",
            },
          }),
          nls.builtins.diagnostics.selene.with({
            condition = function(utils)
              return utils.root_has_file({ "selene.toml" })
            end,
          }),
          nls.builtins.diagnostics.shellcheck,
          nls.builtins.diagnostics.golangci_lint,
        },
        root_dir = require("null-ls.utils").root_pattern(
          ".null-ls-root",
          ".neoconf.json",
          ".git"
        ),
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettier",
        "stylua",
        "selene",
        "eslint_d",
        "shellcheck",
        "shfmt",
        "black",
        "isort",
        "ruff-lsp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          root_dir = require("lspconfig/util").root_pattern(
            "tailwind.config.js",
            "tailwind.config.cjs",
            "tailwind.config.ts",
            "postcss.config.js",
            "postcss.config.ts",
            "package.json",
            "node_modules",
            ".git"
          ),
        },
        csharp_ls = {
          cmd = { "/Users/kwigley/.dotnet/tools/csharp-ls" },
        },
        zls = {
          cmd = { "/Users/kwigley/workspace/zls/zig-out/bin/zls" },
        },
      },
    },
  },
}
