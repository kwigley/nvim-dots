local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
  defaults = {
    layout_strategy = "vertical",
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
    prompt_prefix = "❯ ",
    selection_caret = " ",
    winblend = 5,
  },
})

require("telescope").load_extension("fzf")
telescope.load_extension("gh")

local M = {}

M.project_files = function(opts)
  opts = opts or {}

  local _git_pwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

  if vim.v.shell_error ~= 0 then
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require("telescope.builtin").find_files(opts)
    return
  end

  require("telescope.builtin").git_files(opts)
end

local util = require("util")

util.nnoremap("<Leader><Space>", M.project_files)
util.nnoremap("<Leader>fd", function()
  require("telescope.builtin").git_files({
    cwd = "~/.config/nvim",
  })
end)

return M
