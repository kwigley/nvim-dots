return {
  -- {
  --   "mrcjkb/rustaceanvim",
  --   opts = {
  --     server = {
  --       on_attach = function(_, bufnr)
  --         vim.keymap.set("n", "<leader>cR", function()
  --           vim.cmd.RustLsp("codeAction")
  --         end, { desc = "Code Action", buffer = bufnr })
  --         vim.keymap.set("n", "<leader>dr", function()
  --           vim.cmd.RustLsp("debuggables")
  --         end, { desc = "Rust Debuggables", buffer = bufnr })
  --         vim.keymap.set("n", "<leader>rr", function()
  --           vim.cmd.RustLsp("flyCheck")
  --         end, { desc = "Fly check", buffer = bufnr })
  --         vim.keymap.set("n", "<leader>rc", function()
  --           vim.cmd.RustLsp("flyCheck", "clear")
  --         end, { desc = "Fly check clear", buffer = bufnr })
  --         vim.keymap.set("n", "<leader>rx", function()
  --           vim.cmd.RustLsp("flyCheck", "cancel")
  --         end, { desc = "Fly check cancel", buffer = bufnr })
  --       end,
  --       default_settings = {
  --         -- rust-analyzer language server configuration
  --         ["rust-analyzer"] = {
  --           checkOnSave = false,
  --           -- Enable diagnostics if using rust-analyzer
  --           diagnostics = {
  --             enable = true,
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
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
