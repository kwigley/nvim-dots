-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false -- Relative line numbers
vim.opt.spelloptions:append("camel") -- treat each camelCase word part as its own word

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- turn off autoformatting
vim.g.autoformat = false

vim.g.ai_cmp = false
