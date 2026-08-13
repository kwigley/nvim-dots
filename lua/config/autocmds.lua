-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "python",
  callback = function()
    vim.bo.textwidth = 80
  end,
})

-- Soft wrap keeps prose diffs clean; hard wrapping at 80 splits one paragraph across many lines.
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "markdown",
  callback = function()
    vim.wo.wrap = true
    vim.wo.linebreak = true
  end,
})

-- Markdownlint noise is distracting while prose-editing; hide all diagnostics.
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "markdown",
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})

vim.api.nvim_create_user_command("CopyPath", function()
  local full_path = vim.fn.glob("%:p")
  vim.fn.setreg("+", full_path)
  vim.print("Filepath copied to clipboard!")
end, {
  bang = false,
  nargs = 0,
  force = true,
  desc = "Copy current file path to clipboard",
})

-- Fat fingers. User commands rather than `:Q` normal-mode mappings, which stall
-- a bare `:` for timeoutlen, or cmdline abbreviations, which also expand mid-line.
vim.api.nvim_create_user_command("Q", "quit<bang>", {
  bang = true,
  desc = "Alias for :q",
})

vim.api.nvim_create_user_command("W", "write<bang> <args>", {
  bang = true,
  nargs = "?",
  complete = "file",
  desc = "Alias for :w",
})
