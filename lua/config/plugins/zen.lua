local M = {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  config = {
    plugins = {
      gitsigns = true,
      tmux = true,
      kitty = { enabled = false, font = "+2" },
    },
  },
}

return M
