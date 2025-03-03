return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      model = "claude-3.7-sonnet",
    },
  },
  {
    "Wansmer/treesj",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
}
