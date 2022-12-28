local util = require("util")

local M = {}

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  if M.autoformat then
    util.info("enabled format on save", "Formatting")
  else
    util.warn("disabled format on save", "Formatting")
  end
end

function M.format()
  if M.autoformat then
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    else
      vim.lsp.buf.formatting_sync()
    end
  end
end

function M.setup(client, buf)
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")
  local nls = require("config.plugins.null-ls")

  local enable = false
  if nls.has_formatter(ft) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  if client.name == "tsserver" then
    enable = false
  end

  client.server_capabilities.documentFormattingProvider = enable
  if client.server_capabilities.documentFormattingProvider then
    local group = vim.api.nvim_create_augroup("lsp-format", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function()
        require("config.plugins.lsp.formatting").format()
      end,
      group = group,
    })
  end
end

return M
