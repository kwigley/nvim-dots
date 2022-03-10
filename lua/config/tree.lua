vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1

require("nvim-tree").setup({
  update_to_buf_dir = {
    enable = false,
    auto_open = false,
  },
  ignore_ft_on_setup = { "dashboard", "startify" },
  disable_netrw = true,
  auto_close = true,
  diagnostics = {
    enable = true,
  },
})
