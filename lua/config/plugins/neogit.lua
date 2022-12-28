return {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  config = {
    kind = "split",
    signs = {
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    integrations = { diffview = true },
  },
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
  },
}
