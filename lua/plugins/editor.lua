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
  {
    "Wansmer/treesj",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>sR",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = {
      { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
    },
    config = true,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-calc",
      {
        "zbirenbaum/copilot-cmp",
        config = true,
        dependencies = {
          "zbirenbaum/copilot.lua",
          config = true,
        },
      },
      {
        "saecki/crates.nvim",
        ft = "toml",
        config = true,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-e>"] = cmp.mapping.abort(),
      })
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "copilot" },
        { name = "emoji" },
        { name = "spell" },
        { name = "crates" },
        { name = "calc" },
      }))
      opts.sorting = {
        priority_weight = 2,
        comparators = {
          require("copilot_cmp.comparators").prioritize,
          require("copilot_cmp.comparators").score,

          -- Below is the default comparitor list and order for nvim-cmp
          cmp.config.compare.offset,
          -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
          cmp.config.compare.exact,
          cmp.config.compare.kind,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      }
    end,
  },
}
