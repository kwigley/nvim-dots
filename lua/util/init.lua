_G.dump = function(...)
  print(vim.inspect(...))
end

_G.profile = function(cmd, times)
  times = times or 100
  local args = {}
  if type(cmd) == "string" then
    args = { cmd }
    cmd = vim.cmd
  end
  local start = vim.loop.hrtime()
  for _ = 1, times, 1 do
    local ok = pcall(cmd, unpack(args))
    if not ok then
      error(
        "Command failed: "
          .. tostring(ok)
          .. " "
          .. vim.inspect({ cmd = cmd, args = args })
      )
    end
  end
  print(((vim.loop.hrtime() - start) / 1000000 / times) .. "ms")
end

local M = {}

M.functions = {}

function M.execute(id)
  local func = M.functions[id]
  if not func then
    error("Function doest not exist: " .. id)
  end
  return func()
end

local map = function(mode, key, cmd, opts, defaults)
  opts = vim.tbl_deep_extend(
    "force",
    { silent = true },
    defaults or {},
    opts or {}
  )

  if type(cmd) == "function" then
    table.insert(M.functions, cmd)
    if opts.expr then
      cmd = ([[luaeval('require("util").execute(%d)')]]):format(#M.functions)
    else
      cmd = ("<cmd>lua require('util').execute(%d)<cr>"):format(#M.functions)
    end
  end
  if opts.buffer ~= nil then
    local buffer = opts.buffer
    opts.buffer = nil
    return vim.api.nvim_buf_set_keymap(buffer, mode, key, cmd, opts)
  else
    return vim.api.nvim_set_keymap(mode, key, cmd, opts)
  end
end

function M.map(mode, key, cmd, opt, defaults)
  return map(mode, key, cmd, opt, defaults)
end

function M.nmap(key, cmd, opts)
  return map("n", key, cmd, opts)
end

function M.vmap(key, cmd, opts)
  return map("v", key, cmd, opts)
end

function M.xmap(key, cmd, opts)
  return map("x", key, cmd, opts)
end

function M.imap(key, cmd, opts)
  return map("i", key, cmd, opts)
end

function M.omap(key, cmd, opts)
  return map("o", key, cmd, opts)
end

function M.smap(key, cmd, opts)
  return map("s", key, cmd, opts)
end

function M.nnoremap(key, cmd, opts)
  return map("n", key, cmd, opts, { noremap = true })
end

function M.vnoremap(key, cmd, opts)
  return map("v", key, cmd, opts, { noremap = true })
end

function M.xnoremap(key, cmd, opts)
  return map("x", key, cmd, opts, { noremap = true })
end

function M.inoremap(key, cmd, opts)
  return map("i", key, cmd, opts, { noremap = true })
end

function M.onoremap(key, cmd, opts)
  return map("o", key, cmd, opts, { noremap = true })
end

function M.snoremap(key, cmd, opts)
  return map("s", key, cmd, opts, { noremap = true })
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.log(msg, hl, name)
  name = name or "Neovim"
  hl = hl or "Todo"
  vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function M.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

function M.toggle(option, silent)
  local info = vim.api.nvim_get_option_info(option)
  local scopes = { buf = "bo", win = "wo", global = "o" }
  local scope = scopes[info.scope]
  local options = vim[scope]
  options[option] = not options[option]
  if silent ~= true then
    if options[option] then
      M.info("enabled vim." .. scope .. "." .. option, "Toggle")
    else
      M.warn("disabled vim." .. scope .. "." .. option, "Toggle")
    end
  end
end

function M.toggle_tabline()
  local value = vim.api.nvim_get_option_value("showtabline", {})

  if value == 2 then
    value = 0
  else
    value = 2
  end

  vim.opt.showtabline = value

  M.info("showtabline" .. " set to " .. tostring(value))
end

local diagnostics_active = true
function M.toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

function M.float_terminal(cmd)
  local buf = vim.api.nvim_create_buf(false, true)
  local vpad = 4
  local hpad = 10
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = vim.o.columns - hpad * 2,
    height = vim.o.lines - vpad * 2,
    row = vpad,
    col = hpad,
    style = "minimal",
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  })
  vim.fn.termopen(cmd)
  local group = vim.api.nvim_create_augroup("float-term", { clear = true })
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = 0,
    callback = function()
      vim.api.nvim_win_close(win, { force = true })
      vim.api.nvim_buf_delete(buf, { force = true })
    end,
    group = group,
  })
  vim.cmd([[startinsert]])
end

local path_sep = "/"
M.cache_dir = os.getenv("HOME")
  .. path_sep
  .. ".cache"
  .. path_sep
  .. "nvim"
  .. path_sep

return M
