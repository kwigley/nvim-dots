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
      require("claude-code").setup({
        command = "~/.claude/local/claude",
        window = {
          split_ratio = 0.3, -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
          position = "vertical", -- Position of the window: "botright", "topleft", "vertical", "rightbelow vsplit", etc.
          enter_insert = true, -- Whether to enter insert mode when opening Claude Code
          hide_numbers = true, -- Hide line numbers in the terminal window
          hide_signcolumn = true, -- Hide the sign column in the terminal window
        },
      })
    end,
  },
}
