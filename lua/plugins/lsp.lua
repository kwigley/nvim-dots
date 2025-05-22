return {
  {
    "zbirenbaum/copilot.lua",
    optional = true,
    opts = {
      filetypes = { ["*"] = true },
      copilot_model = "claude-sonnet-4",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = { prefix = "icons" } },
      servers = {
        helm_ls = {
          ["helm-ls"] = {
            yamlls = {
              path = "yaml-language-server",
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
