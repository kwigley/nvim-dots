# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration based on LazyVim, a modular Neovim distribution. The configuration uses lazy.nvim for plugin management and follows a structured approach where plugins and configurations are separated into logical modules.

## Architecture

### Bootstrap & Entry Point
- `init.lua` - Single-line entry point that loads the lazy.nvim configuration
- `lua/config/lazy.lua` - Bootstraps lazy.nvim plugin manager and defines the plugin specification structure

### Configuration Structure
The configuration follows LazyVim's convention of separating concerns into distinct directories:

- `lua/config/` - Core Neovim configurations that are loaded before plugins
  - `options.lua` - Vim options (loaded automatically before lazy.nvim)
  - `keymaps.lua` - Custom keybindings (loaded on VeryLazy event)
  - `autocmds.lua` - Auto-commands and custom commands (loaded on VeryLazy event)

- `lua/plugins/` - Plugin specifications organized by category
  - `lsp.lua` - LSP server configurations (helm_ls, yamlls, jsonls)
  - `editor.lua` - Editor enhancement plugins (venv-selector, treesj)
  - `ui.lua` - UI customizations (bufferline, lualine, barbecue)
  - `ai.lua` - AI assistant integrations (copilot, claudecode.nvim)
  - `git.lua` - Git-related plugins (gitlinker, git-conflict)
  - `treesitter.lua` - Treesitter configuration

### Plugin Loading Strategy
- LazyVim plugins are imported via `import = "lazyvim.plugins"`
- Custom plugins in `lua/plugins/` are imported and set to lazy load by default
- Most plugins use event-based loading (VeryLazy, BufReadPre) for performance
- Rocks support is explicitly disabled

## Development Workflow

### Code Quality & Formatting
```bash
# Format Lua code using StyLua (configured in stylua.toml)
stylua .

# Run pre-commit hooks manually
pre-commit run --all-files

# Install pre-commit hooks
pre-commit install
```

**Formatting Standards:**
- 2-space indentation
- 90 character column width
- Pre-commit hooks enforce: trailing whitespace removal, EOF fixes, YAML/TOML validation, and StyLua formatting

### Testing Changes
Since this is a personal Neovim config, testing is done by:
1. Reloading Neovim after changes
2. Using `:Lazy` to manage plugins (install, update, clean)
3. Using `:LazyHealth` to check for issues
4. Verifying plugin functionality through normal usage

### Plugin Management
```vim
:Lazy                " Open plugin manager UI
:Lazy sync           " Install missing plugins and update existing ones
:Lazy clean          " Remove unused plugins
:Lazy profile        " Profile startup time
:LazyHealth          " Run health checks
```

## Key Customizations

### LSP Configurations
LSP servers have custom settings in `lua/plugins/lsp.lua`:
- `helm_ls` integrates with yaml-language-server
- `yamlls` has keyOrdering disabled to prevent auto-sorting
- `jsonls` has formatting disabled

### Editor Behavior
Notable customizations in `lua/config/options.lua`:
- Relative line numbers disabled
- Intro message suppressed
- Auto-pairs disabled (minipairs)
- All external language providers disabled (Python, Node, Ruby, Perl)
- Text wrapping disabled by default (formatoptions)

### Auto-commands
- Cursorline only shows in active window (InsertLeave/WinEnter/InsertEnter/WinLeave)
- Python and Markdown files have textwidth set to 80
- `:CopyPath` command copies full file path to clipboard

## CI/CD

The repository uses GitHub Actions for continuous integration:
- Workflow: `.github/workflows/pre-commit.yml`
- Runs on: PRs and pushes to `main` or `test-me-*` branches
- Executes all pre-commit hooks using Python 3.x

## Important Notes

- When modifying plugin specs, follow lazy.nvim's specification format
- Plugin options should be defined in the `opts` table when possible
- Use `event`, `cmd`, or `keys` for lazy loading plugins appropriately
- LazyVim defaults are always loaded first; custom configs override them
- The `lazy-lock.json` file is committed to ensure reproducible plugin versions
