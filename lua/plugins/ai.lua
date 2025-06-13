return {
  {
    "zbirenbaum/copilot.lua",
    optional = true,
    opts = {
      filetypes = { ["*"] = true },
    },
  },
  {
    "coder/claudecode.nvim",
    opts = {
      terminal_cmd = "~/.claude/local/claude",
    },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    },
  },
}
