local M = {}
local actions = require("lir.actions")
local mark_actions = require("lir.mark.actions")
local clipboard_actions = require("lir.clipboard.actions")

function M.setup()
  require("lir").setup({
    show_hidden_files = false,
    devicons_enable = true,
    mappings = {
      ["<CR>"] = actions.edit,
      ["<C-s>"] = actions.split,
      ["<C-v>"] = actions.vsplit,
      ["<C-t>"] = actions.tabedit,

      ["-"] = actions.up,
      ["q"] = actions.quit,
      ["<ESC>"] = actions.quit,

      ["K"] = actions.mkdir,
      ["N"] = actions.newfile,
      ["R"] = actions.rename,
      ["@"] = actions.cd,
      ["Y"] = actions.yank_path,
      ["."] = actions.toggle_show_hidden,
      ["D"] = actions.delete,

      ["J"] = function()
        mark_actions.toggle_mark()
        vim.cmd("normal! j")
      end,
      ["C"] = clipboard_actions.copy,
      ["X"] = clipboard_actions.cut,
      ["P"] = clipboard_actions.paste,
    },
    float = {
      winblend = 10,
    },
  })

  require("lir.git_status").setup({
    show_ignored = true,
  })

  local group = vim.api.nvim_create_augroup("lir-settings", { clear = true })
  vim.api.nvim_create_autocmd("Filetype", {
    pattern = "lir",
    callback = function()
      vim.api.nvim_buf_set_keymap(
        0,
        "x",
        "J",
        ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
        { noremap = true, silent = true }
      )

      -- echo cwd
      vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
    end,
    group = group,
  })

  vim.api.nvim_set_keymap(
    "n",
    "-",
    [[<Cmd>execute 'e ' .. expand('%:p:h')<CR>]],
    { noremap = true, silent = true }
  )
end

return M
