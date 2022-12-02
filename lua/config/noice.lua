local M = {}

function M.setup()
  require("noice").setup({
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      inc_rename = true,
      lsp_doc_border = true,
      long_message_to_split = true,
    },
  })
  require("telescope").load_extension("noice")
end

return M
