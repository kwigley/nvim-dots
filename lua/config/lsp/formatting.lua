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
    vim.lsp.buf.format()
  end
end

function M.setup(client, buf)
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")
  local nls = require("config.lsp.null-ls")

  local enable = false
  if nls.has_formatter(ft) then
    enable = client.name == "null-ls"
  else
    -- svelte lsp has good formatting integration!
    if ft == "svelte" then
      if client.name == "svelte" then
        enable = true
      else
        enable = false
      end
    else
      enable = not (client.name == "null-ls")
    end
  end

  client.server_capabilities.document_formatting = enable
  -- format on save
  if enable then
    local group = vim.api.nvim_create_augroup("lsp-format", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function()
        require("config.lsp.formatting").format()
      end,
      group = group,
    })
  end
end

return M
