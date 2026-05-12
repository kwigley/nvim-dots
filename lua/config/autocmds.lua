-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python", "markdown" },
  callback = function()
    vim.bo.textwidth = 80
  end,
})

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
