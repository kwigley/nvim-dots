local wk = require("which-key")
local util = require("util")

vim.o.timeoutlen = 300

wk.setup({
  show_help = false,
  show_keys = false,
  triggers = "auto",
  plugins = { spelling = true },
  key_labels = { ["<leader>"] = "SPC" },
})

-- Fat fingers
vim.keymap.set("n", ":Q", ":q<CR>")
vim.keymap.set("n", ":W", ":w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

-- Move Lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Switch buffers with tab
vim.keymap.set("n", "<C-Left>", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<C-Right>", "<cmd>bnext<cr>")

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
vim.keymap.set("n", "gw", "*N")
vim.keymap.set("x", "gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- save in insert mode
vim.keymap.set("i", "<C-s>", "<cmd>:w<cr><esc>")
vim.keymap.set("n", "<C-s>", "<cmd>:w<cr><esc>")
vim.keymap.set("n", "<C-c>", "<cmd>normal ciw<cr>a")

-- Esc twice to get to normal mode
vim.cmd([[tnoremap <esc><esc> <C-\><C-N>]])

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<space>cu", function()
  local number = math.random(2 ^ 127 + 1, 2 ^ 128)
  return "i" .. string.format("%.0f", number)
end, {
  expr = true,
  desc = "GUID",
})

-- makes * and # work on visual mode too.
vim.cmd([[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]])

local leader = {
  ["w"] = {
    name = "+windows",
    ["w"] = { "<C-W>p", "other-window" },
    ["d"] = { "<C-W>c", "delete-window" },
    ["-"] = { "<C-W>s", "split-window-below" },
    ["|"] = { "<C-W>v", "split-window-right" },
    ["2"] = { "<C-W>v", "layout-double-columns" },
    ["h"] = { "<C-W>h", "window-left" },
    ["j"] = { "<C-W>j", "window-below" },
    ["l"] = { "<C-W>l", "window-right" },
    ["k"] = { "<C-W>k", "window-up" },
    ["H"] = { "<C-W>5<", "expand-window-left" },
    ["J"] = { ":resize +5", "expand-window-below" },
    ["L"] = { "<C-W>5>", "expand-window-right" },
    ["K"] = { ":resize -5", "expand-window-up" },
    ["="] = { "<C-W>=", "balance-window" },
    ["s"] = { "<C-W>s", "split-window-below" },
    ["v"] = { "<C-W>v", "split-window-right" },
  },
  c = {
    name = "+code",
  },
  b = {
    name = "+buffer",
    ["b"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
    ["p"] = { "<cmd>:bp<CR>", "Previous Buffer" },
    ["["] = { "<cmd>:bp<CR>", "Previous Buffer" },
    ["n"] = { "<cmd>:bn<CR>", "Next Buffer" },
    ["]"] = { "<cmd>:bn<CR>", "Next Buffer" },
    ["d"] = { "<cmd>:Bdelete this<CR>", "Delete Buffer" },
    ["o"] = { "<cmd>:Bdelete other<CR>", "Delete Other Buffers" },
    ["a"] = { "<cmd>:Bdelete all<CR>", "Delete All Buffers" },
  },
  g = {
    name = "+git",
    d = { "<cmd>DiffviewOpen<cr>", "Diff" },
    c = { "<Cmd>Telescope git_commits<CR>", "commits" },
    b = { "<Cmd>Telescope git_branches<CR>", "branches" },
    s = { "<Cmd>Telescope git_status<CR>", "status" },
    w = { "<Cmd>Telescope gh run<CR>", "runs" },
    i = { "<Cmd>Telescope gh issues<CR>", "issues" },
    p = { "<Cmd>Telescope gh pull_request<CR>", "PRs" },
    x = { "<Cmd>GitConflictListQf<CR>", "list conflicts" },
    t = { name = "+toggle" },
    h = { name = "+hunk" },
  },
  ["h"] = {
    name = "+help",
    t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
    c = { "<cmd>:Telescope commands<cr>", "Commands" },
    h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
    m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
    k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
    s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
    l = { vim.show_pos, "Highlight Groups at cursor" },
    f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
    o = { "<cmd>:Telescope vim_options<cr>", "Options" },
    a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
  },
  s = {
    name = "+search",
    g = { "<cmd>Telescope live_grep<cr>", "Grep" },
    b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
    s = {
      function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        })
      end,
      "Goto Symbol",
    },
    h = { "<cmd>Telescope command_history<cr>", "Command History" },
    m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
    w = { "<cmd>Telescope grep_string theme=ivy<cr>", "Grep current string" },
    r = { "<cmd>lua require('spectre').open()<CR>", "Replace (Spectre)" },
    u = { "<cmd>Telescope undo<cr>", "Undo History" },
  },
  f = {
    name = "+file",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    n = { "<cmd>enew<cr>", "New File" },
    c = { "<cmd>let @*=expand('%')<cr>", "Copy relative path" },
    C = { "<cmd>let @*=expand('%:p')<cr>", "Copy absolute path" },
    t = { "<cmd>NvimTreeFindFileToggle<cr>", "Toggle Nvim Tree" },
  },
  o = {
    name = "+open",
    g = { "<cmd>Glow<cr>", "Markdown Glow" },
  },
  t = {
    name = "toggle",
    f = {
      require("config.plugins.lsp.formatting").toggle,
      "Format on Save",
    },
    s = {
      function()
        util.toggle("spell")
      end,
      "Spelling",
    },
    w = {
      function()
        util.toggle("wrap")
      end,
      "Word Wrap",
    },
    n = {
      function()
        util.toggle("relativenumber", true)
        util.toggle("number")
      end,
      "Line Numbers",
    },
  },
  ["<tab>"] = {
    name = "tabs",
    ["<tab>"] = { "<cmd>tabnew<CR>", "New Tab" },
    n = { "<cmd>tabnext<CR>", "Next" },
    d = { "<cmd>tabclose<CR>", "Close" },
    p = { "<cmd>tabprevious<CR>", "Previous" },
    ["]"] = { "<cmd>tabnext<CR>", "Next" },
    ["["] = { "<cmd>tabprevious<CR>", "Previous" },
    f = { "<cmd>tabfirst<CR>", "First" },
    l = { "<cmd>tablast<CR>", "Last" },
  },
  ["`"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
  [" "] = "Find File",
  [","] = {
    "<cmd>Telescope buffers show_all_buffers=true<cr>",
    "Switch Buffer",
  },
  ["/"] = { "<cmd>Telescope live_grep<cr>", "Search" },
  [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
  q = {
    name = "+quit/session",
    q = { "<cmd>qa<cr>", "Quit" },
    ["!"] = { "<cmd>:qa!<cr>", "Quit without saving" },
    s = { [[<cmd>lua require("persistence").load()<cr>]], "Restore Session" },
    l = {
      [[<cmd>lua require("persistence").load({last=true})<cr>]],
      "Restore Last Session",
    },
    d = {
      [[<cmd>lua require("persistence").stop()<cr>]],
      "Stop Current Session",
    },
  },
  x = {
    name = "+errors",
    x = { "<cmd>TroubleToggle<cr>", "Trouble" },
    w = {
      "<cmd>TroubleToggle workspace_diagnostics<cr>",
      "Workspace Trouble",
    },
    d = {
      "<cmd>TroubleToggle document_diagnostics<cr>",
      "Document Trouble",
    },
    l = { "<cmd>TroubleToggle loclist<cr>", "Open Location List" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Open Quickfix List" },
    t = { "<cmd>TroubleToggle todo<cr>", "Todo Trouble" },
  },
  z = { [[<cmd>ZenMode<cr>]], "Zen Mode" },
  T = {
    function()
      util.test(true)
    end,
    "Plenary Test File",
  },
  D = {
    function()
      util.test()
    end,
    "Plenary Test Directory",
  },
  n = {
    name = "+noice",
  },
}

for i = 0, 10 do
  leader[tostring(i)] = "which_key_ignore"
end

wk.register(leader, { prefix = "<leader>" })

wk.register({ g = { name = "+goto" } })
