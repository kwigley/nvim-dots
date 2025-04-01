vim.api.nvim_create_user_command("CopyPath", function()
  local full_path = vim.fn.glob("%:p")
  vim.fn.setreg("+", full_path)
  vim.print("Filepath copied to clipboard!")
end, {
  bang = false,
  nargs = 0,
  force = true,
  desc = "Copy current file path to clipboard",
})
