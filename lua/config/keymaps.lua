-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Fat fingers
vim.keymap.set("n", ":Q", ":q<CR>")
vim.keymap.set("n", ":W", ":w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- Open current direction in Finder
vim.keymap.set("n", "<leader>o", function()
  vim.fn.system({ "open", vim.fn.expand("%:p:h") })
end, { desc = "Open current directory in Finder" })

if not vim.g.vscode then
  -- Move to window using the <ctrl> hjkl keys
  vim.keymap.set(
    "n",
    "<C-h>",
    "<cmd>KittyNavigateLeft<cr>",
    { desc = "Go to left window", silent = true, noremap = true }
  )
  vim.keymap.set(
    "n",
    "<C-j>",
    "<cmd>KittyNavigateDown<cr>",
    { desc = "Go to lower window", silent = true, noremap = true }
  )
  vim.keymap.set(
    "n",
    "<C-k>",
    "<cmd>KittyNavigateUp<cr>",
    { desc = "Go to upper window", silent = true, noremap = true }
  )
  vim.keymap.set(
    "n",
    "<C-l>",
    "<cmd>KittyNavigateRight<cr>",
    { desc = "Go to right window", silent = true, noremap = true }
  )
end

-- change wmrd with <c-c>
vim.keymap.set("n", "<C-c>", "<cmd>normal! ciw<cr>a")
