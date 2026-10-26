return {
  { "rawnly/rex.nvim", opts = {} },
  {
    "linux-cultist/venv-selector.nvim",
    branch = "main",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    -- Loaded on python buffers so the cached venv auto-activates; the plugin
    -- hangs that off its own FileType/BufEnter autocmds during setup.
    ft = "python",
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select venv" },
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
  {
    "bullets-vim/bullets.vim",
    ft = { "markdown", "gitcommit", "text" },
    init = function()
      vim.g.bullets_enabled_file_types = { "markdown", "gitcommit", "text" }
    end,
  },
}
