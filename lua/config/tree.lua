vim.g.nvim_tree_ignore = { ".git", "node_modules" }
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_auto_ignore_ft = { "dashboard", "startify" }
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_disable_netrw = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_quit_on_open = 1

require("nvim-tree").setup({
  update_to_buf_dir = {
    enable = false,
    auto_open = false,
  },
})
