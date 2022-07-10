local wk = require("which-key")
local util = require("util")

vim.o.timeoutlen = 300

local presets = require("which-key.plugins.presets")
presets.objects["a("] = nil
wk.setup({
  show_help = false,
  triggers = "auto",
  plugins = { spelling = true },
  key_labels = { ["<leader>"] = "SPC" },
})

-- Fat fingers
util.nnoremap(":Q", ":q<CR>")
util.nnoremap(":W", ":w<CR>")
util.nnoremap("<C-s>", ":w<CR>")

-- Resize window using <shift> arrow keys
util.nnoremap("<S-Up>", ":resize +2<CR>")
util.nnoremap("<S-Down>", ":resize -2<CR>")
util.nnoremap("<S-Left>", ":vertical resize -2<CR>")
util.nnoremap("<S-Right>", ":vertical resize +2<CR>")

-- Move Lines
util.nnoremap("<A-j>", ":m .+1<CR>==")
util.vnoremap("<A-j>", ":m '>+1<CR>gv=gv")
util.inoremap("<A-j>", "<Esc>:m .+1<CR>==gi")
util.nnoremap("<A-k>", ":m .-2<CR>==")
util.vnoremap("<A-k>", ":m '<-2<CR>gv=gv")
util.inoremap("<A-k>", "<Esc>:m .-2<CR>==gi")

-- Easier pasting
util.nnoremap("[p", ":pu!<cr>")
util.nnoremap("]p", ":pu<cr>")

-- Clear search with <esc>
util.map("", "<esc>", ":noh<cr>")
util.nnoremap("gw", "*N")
util.xnoremap("gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
util.nnoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.xnoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.onoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.nnoremap("N", "'nN'[v:searchforward]", { expr = true })
util.xnoremap("N", "'nN'[v:searchforward]", { expr = true })
util.onoremap("N", "'nN'[v:searchforward]", { expr = true })

-- Esc twice to get to normal mode
vim.cmd([[tnoremap <esc><esc> <C-\><C-N>]])

-- better indenting
util.vnoremap("<", "<gv")
util.vnoremap(">", ">gv")

wk.register({
  ["]"] = {
    name = "next",
    r = {
      '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>',
      "Next Reference",
    },
  },
  ["["] = {
    name = "previous",
    r = {
      '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
      "Next Reference",
    },
  },
})

-- makes * and # work on visual mode too.
vim.api.nvim_exec(
  [[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]],
  false
)

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
    ["t"] = { "<C-W>v:terminal<CR>", "split-terminal-right" },
    ["s"] = { "<C-W>s", "split-window-below" },
    ["v"] = { "<C-W>v", "split-window-right" },
  },
  b = {
    name = "+buffer",
    ["b"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
    ["p"] = { "<cmd>:bp<CR>", "Previous Buffer" },
    ["["] = { "<cmd>:bp<CR>", "Previous Buffer" },
    ["n"] = { "<cmd>:bn<CR>", "Next Buffer" },
    ["]"] = { "<cmd>:bn<CR>", "Next Buffer" },
    -- ["p"] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
    -- ["["] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
    -- ["n"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
    -- ["]"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
    ["d"] = { "<cmd>:Bdelete this<CR>", "Delete Buffer" },
    ["o"] = { "<cmd>:Bdelete other<CR>", "Delete Other Buffers" },
    ["a"] = { "<cmd>:Bdelete all<CR>", "Delete All Buffers" },
    -- ["g"] = { "<cmd>:BufferLinePick<CR>", "Goto Buffer" },
  },
  c = {
    name = "+{qf,loc}list",
    c = { "<cmd>QFToggle!<CR>", "Toggle qf list" },
    l = { "<cmd>LLToggle!<CR>", "Toggle loc list" },
    n = { "<cmd>QNext<CR>", "Next item on the qf/loc list" },
    p = { "<cmd>QPrev<CR>", "Prev item on the qf/loc list" },
  },
  g = {
    name = "+git",
    g = { "<cmd>Neogit<CR>", "NeoGit" },
    c = { "<Cmd>Telescope git_commits<CR>", "commits" },
    b = { "<Cmd>Telescope git_branches<CR>", "branches" },
    s = { "<Cmd>Telescope git_status<CR>", "status" },
    w = { "<Cmd>Telescope gh run<CR>", "runs" },
    i = { "<Cmd>Telescope gh issues<CR>", "issues" },
    p = { "<Cmd>Telescope gh pull_request<CR>", "PRs" },
    x = { "<Cmd>GitConflictListQf<CR>", "list conflicts" },
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
    l = {
      [[<cmd>TSHighlightCapturesUnderCursor<cr>]],
      "Highlight Groups at cursor",
    },
    f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
    o = { "<cmd>:Telescope vim_options<cr>", "Options" },
    a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
    p = {
      name = "+packer",
      p = { "<cmd>PackerSync<cr>", "Sync" },
      s = { "<cmd>PackerStatus<cr>", "Status" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      c = { "<cmd>PackerCompile<cr>", "Compile" },
    },
  },
  ["J"] = {
    "<cmd>lua require('trevj').format_at_cursor()<CR>",
    "Split args",
  },
  u = { "<cmd>UndotreeToggle<CR>", "Undo Tree" },
  s = {
    name = "+search",
    g = { "<cmd>Telescope live_grep<cr>", "Grep" },
    b = {
      "<cmd>Telescope current_buffer_fuzzy_find theme=ivy <cr>",
      "Buffer",
    },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Goto Symbol" },
    h = {
      "<cmd>Telescope command_history<cr>",
      "Command History",
    },
    m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
    w = { "<cmd>Telescope grep_string theme=ivy<cr>", "Grep current string" },
    r = { "<cmd>lua require('spectre').open()<CR>", "Replace (Spectre)" },
  },
  f = {
    name = "+file",
    g = { "<cmd>NvimTreeFindFileToggle<cr>", "NvimTree Current File" },
    t = { "<cmd>NvimTreeToggle<cr>", "NvimTree" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    n = { "<cmd>enew<cr>", "New File" },
    c = { "<cmd>let @*=expand('%')<cr>", "Copy relative path" },
    C = { "<cmd>let @*=expand('%:p')<cr>", "Copy absolute path" },
    d = "Dot Files",
  },
  o = {
    name = "+open",
    p = { "<cmd>MarkdownPreview<cr>", "Markdown Preview" },
  },
  p = {
    name = "+project",
    p = "Open Project",
    b = {
      ":Telescope file_browser cwd=~/workspace<CR>",
      "Browse ~/workspace",
    },
  },
  t = {
    name = "toggle",
    f = {
      require("config.lsp.formatting").toggle,
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
    t = {
      function()
        util.toggle_tabline()
      end,
      "Buffer Line",
    },
    d = {
      function()
        util.toggle_diagnostics()
      end,
      "Diagnostics",
    },
  },
  ["<tab>"] = {
    name = "workspace",
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
  [","] = {
    "<cmd>Telescope buffers show_all_buffers=true theme=dropdown<cr>",
    "Switch Buffer",
  },
  ["/"] = { "<cmd>Telescope live_grep<cr>", "Search" },
  [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
  q = {
    name = "+quit/session",
    q = { "<cmd>:qa<cr>", "Quit" },
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
  T = { [[<Plug>PlenaryTestFile]], "Plenary Test" },
}

for i = 0, 10 do
  leader[tostring(i)] = "which_key_ignore"
end

wk.register(leader, { prefix = "<leader>" })
