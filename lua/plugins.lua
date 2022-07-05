local packer = require("util.packer")

local config = {
  profile = {
    enable = false,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  -- display = {
  --   open_fn = function()
  --     return require("packer.util").float({ border = "single" })
  --   end,
  -- },
  -- list of plugins that should be taken from ~/workspace
  -- this is NOT packer functionality!
  -- local_plugins = {
  --   kwigley = true,
  --   ["null-ls.nvim"] = true,
  -- },
}

local function plugins(use)
  use({ "nvim-lua/plenary.nvim", module = "plenary" })
  use({ "nvim-lua/popup.nvim", module = "popup" })

  -- improve startup time
  use({ "lewis6991/impatient.nvim" })
  use({ "nathom/filetype.nvim" })

  -- Packer can manage itself as an optional plugin
  use({ "wbthomason/packer.nvim", opt = true })

  -- UI notifications
  use({
    "rcarriga/nvim-notify",
    event = "BufRead",
    config = function()
      require("config.notify").setup()
    end,
  })

  -- LSP
  use({
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    wants = {
      "nvim-lsp-ts-utils",
      "null-ls.nvim",
      "lua-dev.nvim",
    },
    config = function()
      require("config.lsp")
    end,
    requires = {
      "SmiteshP/nvim-navic",
      "simrat39/rust-tools.nvim",
      "mfussenegger/nvim-dap",
      "mattn/webapi-vim",
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/lua-dev.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
      "ray-x/lsp_signature.nvim",
      {
        "kosayoda/nvim-lightbulb",
        config = function()
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            callback = function()
              require("nvim-lightbulb").update_lightbulb()
            end,
          })
        end,
      },
      {
        "j-hui/fidget.nvim",
        config = function()
          require("fidget").setup({ text = { spinner = "dots" } })
        end,
      },
    },
  })

  -- LSP ui
  use({
    "folke/trouble.nvim",
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup({
        auto_open = false,
        mode = "document_diagnostics",
      })
    end,
  })

  -- autocompletion
  use({
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opt = true,
    config = function()
      require("config.cmp")
    end,
    wants = { "tabout.nvim", "LuaSnip", "nvim-autopairs", "plenary.nvim" },
    requires = {
      "f3fora/cmp-spell",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-buffer",
      {
        "saecki/crates.nvim",
        config = function()
          require("crates").setup()
        end,
      },
      {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        config = function()
          require("config.luasnip")
        end,
      },
      "rafamadriz/friendly-snippets",
      {
        "abecodes/tabout.nvim",
        config = function()
          require("tabout").setup()
        end,
        wants = { "nvim-treesitter" },
      },
      {
        "windwp/nvim-autopairs",
        config = function()
          require("config.autopairs")
        end,
      },
    },
  })

  -- surround selections
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        keymaps = { -- vim-surround style keymaps
          insert = "ys",
          visual = "S",
          delete = "ds",
          change = "cs",
        },
        delimiters = {
          pairs = {
            ["("] = { "( ", " )" },
            [")"] = { "(", ")" },
            ["{"] = { "{ ", " }" },
            ["}"] = { "{", "}" },
            ["<"] = { "< ", " >" },
            [">"] = { "<", ">" },
            ["["] = { "[ ", " ]" },
            ["]"] = { "[", "]" },
          },
          separators = {
            ["'"] = { "'", "'" },
            ['"'] = { '"', '"' },
            ["`"] = { "`", "`" },
          },
          HTML = {
            ["t"] = true, -- Use "t" for HTML-style mappings
          },
          aliases = {
            ["a"] = ">", -- Single character aliases apply everywhere
            ["b"] = ")",
            ["B"] = "}",
            ["r"] = "]",
            ["q"] = { '"', "'", "`" }, -- Table aliases only apply for changes/deletions
          },
        },
      })
    end,
  })

  -- Treesitter: syntax highlighting
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      {
        "nvim-treesitter/playground",
        cmd = "TSHighlightCapturesUnderCursor",
      },
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("config.treesitter")
    end,
  })

  -- Treesitter: convert long function signature to multiline signature
  use({
    "AckslD/nvim-trevJ.lua",
    wants = { "nvim-treesitter" },
    config = function()
      require("trevj").setup()
    end,
  })
  -- code commenting shortcut
  use({
    "numToStr/Comment.nvim",
    wants = "nvim-ts-context-commentstring",
    config = function()
      require("config.comments")
    end,
    requires = "JoosepAlviste/nvim-ts-context-commentstring",
  })

  -- Theme: colors
  use({
    "folke/tokyonight.nvim",
    config = function()
      require("config.theme")
    end,
  })

  -- Theme: icons
  use({
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        override = {
          lir_folder_icon = {
            icon = "",
            color = "#7ebae4",
            name = "LirFolderNode",
          },
        },
        default = true,
      })
    end,
  })

  use({
    "norcalli/nvim-terminal.lua",
    ft = "terminal",
    config = function()
      require("terminal").setup()
    end,
  })

  use({
    "windwp/nvim-spectre",
    opt = true,
    module = "spectre",
    wants = { "plenary.nvim", "popup.nvim" },
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  })

  use({
    "tamago324/lir.nvim",
    wants = { "nvim-web-devicons", "plenary.nvim", "lir-git-status.nvim" },
    requires = { "nvim-lua/plenary.nvim", "tamago324/lir-git-status.nvim" },
    config = function()
      require("config.lir")
    end,
  })

  use({
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeClose", "NvimTreeFindFileToggle" },
    config = function()
      require("config.tree")
    end,
  })

  -- Fuzzy finder
  use({
    "nvim-telescope/telescope.nvim",
    opt = true,
    config = function()
      require("config.telescope")
    end,
    cmd = { "Telescope" },
    keys = { "<leader><space>", "<leader>fd" },
    wants = {
      "plenary.nvim",
      "popup.nvim",
      "telescope-fzf-native.nvim",
      "trouble.nvim",
      "telescope-symbols.nvim",
      "telescope-github.nvim",
    },
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-telescope/telescope-github.nvim",
    },
  })

  -- UI sugar
  use({ "stevearc/dressing.nvim" })

  -- Indent Guides
  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("config.blankline")
    end,
  })

  -- Tabs
  use({
    "akinsho/nvim-bufferline.lua",
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    config = function()
      require("config.bufferline")
    end,
  })
  use({
    "Asheq/close-buffers.vim",
    cmd = { "Bdelete" },
  })

  -- Terminal
  use({
    "akinsho/nvim-toggleterm.lua",
    config = function()
      require("config.terminal")
    end,
  })

  -- Smooth Scrolling
  use({
    "karb94/neoscroll.nvim",
    keys = { "<C-u>", "<C-d>", "gg", "G" },
    config = function()
      require("config.scroll")
    end,
  })
  use({
    "edluffy/specs.nvim",
    after = "neoscroll.nvim",
    config = function()
      require("config.specs")
    end,
  })

  -- Git
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    wants = "plenary.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns")
    end,
  })
  use({
    "ruifm/gitlinker.nvim",
    wants = "plenary.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("config.gitlinker")
    end,
  })
  use({
    "TimUntersberger/neogit",
    cmd = "Neogit",
    wants = {
      "plenary.nvim",
      "diffview.nvim",
    },
    requires = {
      {
        "sindrets/diffview.nvim",
        config = function()
          require("diffview").setup({})
        end,
        after = "plenary.nvim",
      },
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("config.neogit")
    end,
  })
  use({
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup({
        disable_diagnostics = true,
      })
    end,
  })
  -- Statusline
  use({
    "famiu/feline.nvim",
    -- event = "VimEnter",
    config = function()
      require("config.feline")
    end,
    wants = "nvim-web-devicons",
  })

  -- Writing
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
  })
  use({ "jxnblk/vim-mdx-js" })

  use({
    "ggandor/lightspeed.nvim",
    keys = { "s", "S", "f", "F", "t", "T" },
    config = function()
      require("config.lightspeed")
    end,
  })

  use({
    "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  })

  use({ "tweekmonster/startuptime.vim", cmd = "StartupTime" })

  use({ "mbbill/undotree", cmd = "UndotreeToggle" })

  use({
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opt = true,
    wants = "twilight.nvim",
    requires = { "folke/twilight.nvim" },
    config = function()
      require("zen-mode").setup({
        plugins = { gitsigns = true, kitty = { enabled = true, font = "+2" } },
      })
    end,
  })

  use({
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("config.colorizer")
    end,
  })

  use({
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      require("config.todo")
    end,
  })

  use({
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("config.keys")
    end,
  })

  use({
    "RRethy/vim-illuminate",
    event = "CursorHold",
    module = "illuminate",
    config = function()
      vim.g.Illuminate_delay = 1000
      vim.g.Illuminate_ftblacklist = { "lir", "nvimtree" }
    end,
  })

  use({
    "andymass/vim-matchup",
    event = "CursorMoved",
  })

  use({
    "knubie/vim-kitty-navigator",
    run = { "cp *.py $HOME/.config/kitty" },
  })

  -- cue language support
  use({
    "jjo/vim-cue",
  })
end

return packer.setup(config, plugins)
