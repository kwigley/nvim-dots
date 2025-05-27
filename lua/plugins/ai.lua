return {
  {
    "zbirenbaum/copilot.lua",
    optional = true,
    opts = {
      filetypes = { ["*"] = true },
    },
  },
  {
    "greggh/claude-code.nvim",
    lazy = false,
    command = "ClaudeCode",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<C-,>", "<cmd>ClaudeCode<cr>", desc = "Claude Code" },
    },
    config = function()
      require("claude-code").setup()
    end,
  },
}
