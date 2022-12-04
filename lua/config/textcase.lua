local M = {}

function M.setup()
  require("textcase").setup({})

  local ok, telescope = pcall(require, "telescope")
  if not ok then
    return
  end
  telescope.load_extension("textcase")
  vim.api.nvim_set_keymap(
    "n",
    "ga.",
    "<cmd>TextCaseOpenTelescope<CR>",
    { desc = "Telescope" }
  )
  vim.api.nvim_set_keymap(
    "v",
    "ga.",
    "<cmd>TextCaseOpenTelescope<CR>",
    { desc = "Telescope" }
  )
end

return M
