return {
  {
    "linux-cultist/venv-selector.nvim",
    branch = "main",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- Your options go here
      name = ".venv",
      -- auto_refresh = false
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>vs", "<cmd>VenvSelect<cr>" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    },
  },
  {
    "Wansmer/treesj",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    "wasabeef/yank-for-claude.nvim",
    config = function()
      require("yank-for-claude").setup()
    end,
    keys = {
      -- Reference only
      {
        "<leader>cy",
        function()
          require("yank-for-claude").yank_visual()
        end,
        mode = "v",
        desc = "Yank for Claude",
      },
      {
        "<leader>cy",
        function()
          require("yank-for-claude").yank_line()
        end,
        mode = "n",
        desc = "Yank line for Claude",
      },

      -- Reference + Code
      {
        "<leader>cY",
        function()
          require("yank-for-claude").yank_visual_with_content()
        end,
        mode = "v",
        desc = "Yank with content",
      },
      {
        "<leader>cY",
        function()
          require("yank-for-claude").yank_line_with_content()
        end,
        mode = "n",
        desc = "Yank line with content",
      },
    },
  },
}
