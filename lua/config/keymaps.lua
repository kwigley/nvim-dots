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

-- change word with <c-c>
vim.keymap.set("n", "<C-c>", "<cmd>normal! ciw<cr>a")

-- rm floating terminal keymaps
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")

-- Restore 'gw' to default behavior. First, remove the 'gw' keymap set in LazyVim:
vim.keymap.del({ "n", "x" }, "gw")
-- Then, reset formatexpr if null-ls is not providing any formatting generators.
-- See: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
require("lazyvim.util").on_attach(function(client, buf)
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
