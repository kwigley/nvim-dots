-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Fat fingers
vim.keymap.set("n", ":Q", ":q<CR>")
vim.keymap.set("n", ":W", ":w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- Herdr Annotate: yank the visual selection then open the annotate popup
vim.keymap.set("x", "<leader>a", function()
  vim.cmd('normal! "+y')
  vim.fn.jobstart({
    "herdr",
    "plugin",
    "action",
    "invoke",
    "annotate.capture",
  })
end, { desc = "Annotate in Herdr" })
