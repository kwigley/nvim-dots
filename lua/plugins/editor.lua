return {
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    event = "VeryLazy",
  },
  {
    "knubie/vim-kitty-navigator",
    event = "VeryLazy",
    enabled = function()
      return vim.g.vscode == nil
    end,
    config = function()
      vim.g.kitty_navigator_no_mappings = true
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
      filesystem = {
        hijack_netrw_behavior = "disabled",
      },
    },
  },
  {
    "Asheq/close-buffers.vim",
    cmd = { "Bdelete" },
    keys = {
      {
        "<leader>bo",
        "<cmd>:Bdelete other<CR>",
        desc = "Delete Other Buffers",
      },
      {
        "<leader>ba",
        "<cmd>:Bdelete all<CR>",
        desc = "Delete All Buffers",
      },
    },
  },
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
        show_hidden_files = false,
        ignore = {}, -- { ".DS_Store" "node_modules" } etc.
        devicons = {
          enable = true,
          -- highlight_dirname = false
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
    "folke/trouble.nvim",
    keys = {
      {
        "<leader>xn",
        function()
          require("trouble").next({ skip_groups = true, jump = true })
        end,
        desc = "Next Item (Trouble)",
      },
      {
        "<leader>xp",
        function()
          require("trouble").previous({ skip_groups = true, jump = true })
        end,
        desc = "Previous Item (Trouble)",
      },
      {
        "<leader>xgg",
        function()
          require("trouble").first({ skip_groups = true, jump = true })
        end,
        desc = "First Item (Trouble)",
      },
      {
        "<leader>xG",
        function()
          require("trouble").last({ skip_groups = true, jump = true })
        end,
        desc = "Last Item (Trouble)",
      },
    },
  },
  {
    "Wansmer/treesj",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
}
