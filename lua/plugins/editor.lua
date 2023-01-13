return {
  {
    "knubie/vim-kitty-navigator",
    event = "VeryLazy",
    config = function()
      vim.g.kitty_navigator_no_mappings = true
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        hijack_netrw_behavior = "disabled",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = {
          hl = "GitSignsAdd",
          text = "▍",
          numhl = "GitSignsAddNr",
          linehl = "GitSignsAddLn",
        },
        change = {
          hl = "GitSignsChange",
          text = "▍",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        delete = {
          hl = "GitSignsDelete",
          text = "▸",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = "▾",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        changedelete = {
          hl = "GitSignsChange",
          text = "▍",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        untracked = {
          hl = "GitSignsAdd",
          text = "▍",
          numhl = "GitSignsAddNr",
          linehl = "GitSignsAddLn",
        },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- Navigation
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        map(
          "n",
          "<leader>gtb",
          gs.toggle_current_line_blame,
          { desc = "Toggle current line blame" }
        )
        map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted" })
      end,
    },
  },
  {
    "echasnovski/mini.bufremove",
    enabled = false,
  },
  {
    "Asheq/close-buffers.vim",
    cmd = { "Bdelete" },
    keys = {
      {
        "<leader>bd",
        "<cmd>:Bdelete this<CR>",
        desc = "Delete Buffer",
      },
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
    "akinsho/git-conflict.nvim",
    event = "VimEnter",
    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
    },
    opts = {
      disable_diagnostics = true,
    },
    keys = {
      {
        "<leader>gx",
        "<Cmd>GitConflictListQf<CR>",
        desc = "List Git Conflicts",
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
}
