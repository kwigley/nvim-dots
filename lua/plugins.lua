local packer = require("util.packer")

local packer_config = {
  profile = {
    enable = false,
    threshold = 0,
  },
}

local function plugins(use)
  -- common modules used by plugins
  use({ "nvim-lua/plenary.nvim", module = "plenary" })
  use({ "nvim-lua/popup.nvim", module = "popup" })
  -- improve startup time
  use({ "lewis6991/impatient.nvim" })
  use({ "nathom/filetype.nvim" })
  -- Packer can manage itself as an optional plugin
  use({ "wbthomason/packer.nvim", opt = true })
  -- better UI notifications
  use({
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      vim.schedule(function()
        require("config.copilot").setup()
      end)
    end,
  })
  -- LSP
  -- TODO: break up this config into more managable pieces
  use({
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    wants = {
      "null-ls.nvim",
      "neodev.nvim",
    },
    config = function()
      require("config.lsp")
    end,
    requires = {
      {
        "SmiteshP/nvim-navic",
        config = function()
          require("config.navic").setup()
        end,
      },
      "simrat39/rust-tools.nvim",
      "mfussenegger/nvim-dap",
      "mattn/webapi-vim",
      "jose-elias-alvarez/typescript.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      {
        "folke/neodev.nvim",
        config = function()
          require("config.neodev").setup()
        end,
      },
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
      -- "ray-x/lsp_signature.nvim",
      {
        "kosayoda/nvim-lightbulb",
        config = function()
          require("config.lightbulb").setup()
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
      require("config.trouble").setup()
    end,
  })
  use({ "onsails/lspkind.nvim" })
  use({
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  })
  -- autocompletion
  use({
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opt = true,
    config = function()
      require("config.cmp").setup()
    end,
    wants = {
      "tabout.nvim",
      "LuaSnip",
      "nvim-autopairs",
      "plenary.nvim",
      "copilot-cmp",
    },
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
          require("config.crates").setup()
        end,
      },
      {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        config = function()
          require("config.luasnip").setup()
        end,
      },
      "rafamadriz/friendly-snippets",
      {
        "abecodes/tabout.nvim",
        config = function()
          require("config.tabout").setup()
        end,
        wants = { "nvim-treesitter" },
      },
      {
        "windwp/nvim-autopairs",
        config = function()
          require("config.autopairs").setup()
        end,
      },
    },
  })
  -- surround selections
  use({
    "kylechui/nvim-surround",
    tag = "*",
    config = function()
      require("config.surround").setup()
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
      require("config.treesitter").setup()
    end,
  })
  -- Treesitter: convert long function signature to multiline signature
  use({
    "AckslD/nvim-trevJ.lua",
    wants = { "nvim-treesitter" },
    config = function()
      require("config.trevj").setup()
    end,
  })
  -- code commenting shortcut
  use({
    "numToStr/Comment.nvim",
    -- tag = "*",
    wants = "nvim-ts-context-commentstring",
    config = function()
      require("config.comments").setup()
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
      require("config.devicons").setup()
    end,
  })
  use({
    "norcalli/nvim-terminal.lua",
    ft = "terminal",
    config = function()
      require("config.terminal").setup()
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
      require("config.lir").setup()
    end,
  })
  use({
    "kyazdani42/nvim-tree.lua",
    tag = "*",
    cmd = { "NvimTreeToggle", "NvimTreeClose", "NvimTreeFindFileToggle" },
    config = function()
      require("config.tree").setup()
    end,
  })
  -- Fuzzy finder
  use({
    "nvim-telescope/telescope.nvim",
    opt = true,
    config = function()
      require("config.telescope").setup()
    end,
    cmd = { "Telescope" },
    keys = { "<leader><space>", "<leader>fh" },
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
  use({
    "folke/noice.nvim",
    event = "VimEnter",
    config = function()
      require("config.noice").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  })
  -- Indent Guides
  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("config.blankline").setup()
    end,
  })
  use({
    "Asheq/close-buffers.vim",
    cmd = { "Bdelete" },
  })
  -- Terminal
  use({
    "akinsho/nvim-toggleterm.lua",
    tag = "*",
    config = function()
      require("config.toggleterm").setup()
    end,
  })
  -- Smooth Scrolling
  use({
    "karb94/neoscroll.nvim",
    keys = { "<C-u>", "<C-d>", "gg", "G" },
    config = function()
      require("config.scroll").setup()
    end,
  })
  -- Git
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    wants = "plenary.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns").setup()
    end,
  })
  use({
    "ruifm/gitlinker.nvim",
    wants = "plenary.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("config.gitlinker").setup()
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
          require("config.diffview").setup()
        end,
        after = "plenary.nvim",
      },
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("config.neogit").setup()
    end,
  })
  use({
    "akinsho/git-conflict.nvim",
    tag = "*",
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
    config = function()
      require("config.conflict").setup()
    end,
  })
  -- Statusline
  use({
    "feline-nvim/feline.nvim",
    config = function()
      require("config.feline").setup()
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
    "ggandor/leap.nvim",
    keys = { "s", "S", "x", "X" },
    config = function()
      require("config.leap").setup()
    end,
  })
  use({
    "ggandor/leap-ast.nvim",
    needs = "leap.nvim",
    keys = { "f" },
    config = function()
      vim.keymap.set({ "n", "x", "o" }, "f", function()
        require("leap-ast").leap()
      end, {})
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
      require("config.zen").setup()
    end,
  })
  use({
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("config.colorizer").setup()
    end,
  })
  use({
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      require("config.todo").setup()
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
      require("config.illuminate").setup()
    end,
  })
  use({
    "andymass/vim-matchup",
    event = "CursorMoved",
  })
  -- kitty terminal integration
  use({
    "knubie/vim-kitty-navigator",
    run = { "cp *.py $HOME/.config/kitty" },
  })
  -- cue language support
  use({
    "jjo/vim-cue",
  })
  -- qf/loc list helpers
  use({
    "stevearc/qf_helper.nvim",
    config = function()
      require("config.qfhelper").setup()
    end,
  })
  -- persist sessions
  use({
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("config.persistence").setup()
    end,
  })
  use({
    "kkoomen/vim-doge",
    run = ":call doge#install()",
  })
  use({
    "johmsalas/text-case.nvim",
    config = function()
      require("config.textcase").setup()
    end,
  })
end

return packer.setup(packer_config, plugins)
