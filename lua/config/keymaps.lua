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

-- Then, reset formatexpr if null-ls is not providing any formatting generators.
-- See: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
require("lazyvim.util").lsp.on_attach(function(client, buf)
  if client.name == "null-ls" then
    if
      not require("null-ls.generators").can_run(
        vim.bo[buf].filetype,
        require("null-ls.methods").lsp.FORMATTING
      )
    then
      vim.bo[buf].formatexpr = nil
    end
  end
end)

-- scroll lsp docs
vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-f>"
  end
end, { silent = true, expr = true })

vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-b>"
  end
end, { silent = true, expr = true })
