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

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

-- create directories when needed, when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match

    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

-- Fix conceallevel for json & help files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python" },
  callback = function()
    vim.bo.textwidth = 80
  end,
})
