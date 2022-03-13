local wk = require("which-key")
local util = require("util")

local M = {}

function M.setup(client, bufnr)
  -- Mappings.
  local opts = { noremap = true, silent = true, buffer = bufnr }

  local keymap = {
    c = {
      name = "+code",
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
      l = {
        name = "+lsp",
        x = {
          "<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>",
          "Restart Lsp",
        },
        i = { "<cmd>LspInfo<CR>", "Lsp Info" },
        a = {
          "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
          "Add Folder",
        },
        r = {
          "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
          "Remove Folder",
        },
        l = {
          "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
          "List Folders",
        },
      },
    },
    x = {
      s = {
        "<cmd>Telescope document_diagnostics<cr>",
        "Search Document Diagnostics",
      },
      w = {
        "<cmd>Telescope workspace_diagnostics<cr>",
        "Workspace Diagnostics",
      },
    },
  }

  if client.name == "tsserver" then
    keymap.c.o = { "<cmd>TSLspOrganize<CR>", "Organize Imports" }
    keymap.c.R = { "<cmd>TSLspRenameFile<CR>", "Rename File" }
  end

  if client.name == "rust_analyzer" then
    local Terminal = require("toggleterm.terminal").Terminal
    local clippy = Terminal:new({
      cmd = "cargo clippy",
      close_on_exit = false,
      on_exit = function(t, _, exit_code, _)
        if exit_code == 0 then
          t:close()
        end
      end,
    })
    ---@diagnostic disable-next-line: lowercase-global
    function _clippy_toggle()
      clippy:toggle()
    end
    local test = Terminal:new({
      cmd = "cargo test",
      close_on_exit = false,
      on_exit = function(t, _, exit_code, _)
        if exit_code == 0 then
          t:close()
        end
      end,
    })
    ---@diagnostic disable-next-line: lowercase-global
    function _test_toggle()
      test:toggle()
    end

    keymap.c.R = { "<cmd>RustRunnables<CR>", "Rust Runnables" }
    keymap.t = {
      i = { "<cmd>RustToggleInlayHints<CR>", "Rust Toggle Inlay Hints" },
    }
    keymap.c.c = {
      "<cmd>lua _clippy_toggle()<CR>",
      "Run Clippy",
    }
    keymap.c.t = {
      "<cmd>lua _test_toggle()<CR>",
      "Run Tests",
    }
  end

  local keymap_visual = {
    c = {
      name = "+code",
      a = { ":<C-U>lua vim.lsp.buf.range_code_action()<CR>", "Code Action" },
    },
  }

  local keymap_goto = {
    name = "+goto",
    r = { "<cmd>Telescope lsp_references<cr>", "References" },
    R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
    d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
    dv = {
      "<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>",
      "Goto Definition",
    },
    ds = {
      "<Cmd>split | lua vim.lsp.buf.definition()<CR>",
      "Goto Definition",
    },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
    t = {
      "<cmd>lua vim.lsp.buf.type_definition()<CR>",
      "Goto Type Definition",
    },
  }

  util.nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  util.nnoremap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  util.nnoremap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    keymap.c.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Document" }
  elseif client.resolved_capabilities.document_range_formatting then
    keymap_visual.c.f = {
      "<cmd>lua vim.lsp.buf.range_formatting()<CR>",
      "Format Range",
    }
  end

  wk.register(keymap, { buffer = bufnr, prefix = "<leader>" })
  wk.register(
    keymap_visual,
    { buffer = bufnr, prefix = "<leader>", mode = "v" }
  )
  wk.register(keymap_goto, { buffer = bufnr, prefix = "g" })
end

return M
