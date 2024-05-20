return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = { prefix = "icons" } },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
        xml = { "xmlformat" },
      },
    },
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
  { "towolf/vim-helm", ft = "helm" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
      },
      servers = {
        astro = {},
        cssls = {},
        dockerls = {},
        ruff_lsp = {},
        tailwindcss = {},
        tsserver = {},
        helm_ls = {
          ["helm-ls"] = {
            yamlls = {
              path = "yaml-language-server",
            },
          },
        },
        ocamlls = {},
        svelte = {},
        html = {},
        gopls = {},
        rust_analyzer = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
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
      },
    },
  },
}
