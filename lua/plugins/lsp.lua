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
          nls.builtins.diagnostics.flake8,
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
        "deno",
        "shfmt",
        "black",
        "isort",
        "flake8",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {},
        bashls = {},
        dockerls = {},
        svelte = {},
        cssls = {},
        html = {},
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
        clangd = {},
        gopls = {},
        yamlls = {},
        sumneko_lua = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  "--log-level=trace",
                },
              },
              diagnostics = {
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        terraformls = {},
        prismals = {},
        taplo = {},
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
