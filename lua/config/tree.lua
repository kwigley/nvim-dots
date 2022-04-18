vim.g.nvim_tree_git_hl = 1

require("nvim-tree").setup({
  update_to_buf_dir = {
    enable = false,
    auto_open = false,
  },
  ignore_ft_on_setup = { "dashboard", "startify" },
  disable_netrw = true,
  diagnostics = {
    enable = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
    },
  },
})
