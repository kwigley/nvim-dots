return {
  {
    "knubie/vim-kitty-navigator",
    build = "cp ./*.py ~/.config/kitty/",
    event = "VeryLazy",
    enabled = function()
      return vim.g.vscode == nil
    end,
    config = function()
      vim.g.kitty_navigator_no_mappings = true
    end,
  },
  { "neo-tree.nvim", enabled = false },
  {
    "tamago324/lir.nvim",
    event = "VeryLazy",
    dependencies = {
      "tamago324/lir-git-status.nvim",
    },
    config = function()
      local actions = require("lir.actions")
      local mark_actions = require("lir.mark.actions")
      local clipboard_actions = require("lir.clipboard.actions")

      require("lir").setup({
        hide_cursor = false,
        show_hidden_files = false,
        ignore = {},
        devicons = {
          enable = true,
          highlight_dirname = true,
        },
        mappings = {
          ["<CR>"] = actions.edit,
          ["<C-s>"] = actions.split,
          ["<C-v>"] = actions.vsplit,
          ["<C-t>"] = actions.tabedit,

          ["-"] = actions.up,
          ["<ESC>"] = actions.quit,

          ["K"] = actions.mkdir,
          ["N"] = actions.newfile,
          ["R"] = actions.rename,
          ["@"] = actions.cd,
          ["Y"] = actions.yank_path,
          ["."] = actions.toggle_show_hidden,
          ["D"] = actions.wipeout,

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
          curdir_window = {
            enable = false,
            highlight_dirname = false,
          },
        },
        on_init = function()
          -- use visual mode
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
      })

      require("lir.git_status").setup({
        show_ignored = true,
      })
      vim.api.nvim_set_keymap(
        "n",
        "-",
        [[<cmd>execute 'e ' .. expand('%:p:h')<cr>]],
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "Wansmer/treesj",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
}
