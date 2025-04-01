-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Fat fingers
vim.keymap.set("n", ":Q", ":q<CR>")
vim.keymap.set("n", ":W", ":w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")

vim.api.nvim_create_user_command("CopyPath", function()
  local full_path = vim.fn.glob("%:p")
  vim.fn.setreg("+", full_path)
  vim.print("Filepath copied to clipboard!")
end, {
  bang = false,
  nargs = 1,
  force = true,
  desc = "Copy current file path to clipboard",
})
