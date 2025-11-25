-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.shortmess:append("I") -- don't give the intro message when starting Vim |:intro|
vim.opt.formatoptions:remove("t")
vim.opt.relativenumber = false -- Relative line numbers

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- turn off autoformatting
vim.g.autoformat = false

-- turn off autopairs
vim.g.minipairs_disable = true

-- Native inline completions don't support being shown as regular completions
vim.g.ai_cmp = false

-- Use bacon-ls for Rust diagnostics
vim.g.lazyvim_rust_diagnostics = "bacon-ls"
