return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "ThePrimeagen/refactoring.nvim" },
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.code_actions.refactoring,
        nls.builtins.code_actions.gitsigns,
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
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "yamllint",
        "stylua",
        "selene",
        "eslint_d",
        "shellcheck",
        "shfmt",
        "black",
        "isort",
        "ruff-lsp",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {},
        cssls = {},
        dockerls = {},
        ruff_lsp = {},
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        svelte = {},
        html = {},
        gopls = {},
        pyright = {},
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              procMacro = { enable = true },
              cargo = { allFeatures = true },
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        teal_ls = {},
        vimls = {},
        jsonls = {
          settings = {
            json = {
              format = {
                enable = false,
              },
            },
          },
        },
        csharp_ls = {
          cmd = { "/Users/kwigley/.dotnet/tools/csharp-ls" },
        },
      },
    },
  },
  -- inlay hints
  {
    "lvimuser/lsp-inlayhints.nvim",
    branch = "anticonceal",
    event = "LspAttach",
    opts = {},
    config = function(_, opts)
      require("lsp-inlayhints").setup(opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end
          ---@type lsp.Client
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf, false)
        end,
      })
    end,
  },
}
