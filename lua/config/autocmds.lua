-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- ftdetect
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*.fish", command = "setfiletype fish" }
)
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*.nix", command = "setfiletype nix" }
)
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*.hcl", command = "setfiletype hcl" }
)
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = ".terraform,terraform.rc", command = "setfiletype hcl" }
)
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*.tf,*.tfvars", command = "setfiletype terraform" }
)
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*.tfstate,*.tfvars.backup", command = "setfiletype json" }
)
