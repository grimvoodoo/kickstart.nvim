# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.
``

Repository type: Neovim configuration (Kickstart-based, single-file core with modular extensions)

Common commands
- Launch Neovim (installs/bootstraps plugins on first run):
  - nvim
- Sync or update plugins headlessly:
  - nvim --headless "+Lazy! sync" +qa
  - nvim --headless "+Lazy! update" +qa
- Update Treesitter parsers (sync, in headless mode):
  - nvim --headless "+TSUpdateSync" +qa
- Install/ensure LSPs/tools declared in config (mason-tool-installer):
  - nvim --headless "+MasonToolsInstall" +qa
- Check environment and plugin health:
  - nvim --headless "+checkhealth" +qa
- Format Lua using repo style (.stylua.toml):
  - stylua .
- Quick Lua syntax check (optional):
  - find lua -name "*.lua" -print0 | xargs -0 -n1 luac -p

Environment and prerequisites (from README highlights)
- Neovim: latest stable or nightly
- External tools often expected by the config and its plugins: git, make, unzip, gcc/cc, ripgrep
- Recommended: Nerd Font installed and selected in your terminal (init.lua sets vim.g.have_nerd_font = true)

Big-picture architecture
- Single-file core entrypoint: init.lua
  - Sets core options, keymaps, autocommands
  - Bootstraps lazy.nvim and defines the plugin spec via require('lazy').setup({...}, { ui = ... })
  - Applies a global UI preference for Nerd Font icons
  - Selects the colorscheme (tokyonight-night)
  - Declares Plugins: Telescope, Treesitter, LSP stack (mason, mason-lspconfig, mason-tool-installer), blink.cmp, conform.nvim (formatting), which-key, mini.nvim modules, todo-comments, gitsigns, web-devicons
  - LSP configuration
    - Registers on-attach keymaps for rename (grn), code action (gra), references (grr), implementation (gri), definition (grd), declaration (grD), document/workspace symbols (gO/gW), type definition (grt)
    - Optional highlight of references and inlay hints when supported
    - Capabilities integrated with blink.cmp
    - Servers table provides overrides (lua_ls settings for completion)
    - Installation lifecycle: mason + mason-lspconfig + mason-tool-installer coordinate tool/server availability; :MasonToolsInstall installs those listed in ensure_installed
    - Mason tools are now declared in code including: LSPs (lua, html, css, python, bash, json, yaml, markdown, terraform), formatters (stylua, prettier, black, yamlfmt, shfmt), and linters
  - Formatting
    - conform.nvim provides <leader>f mapping for on-demand formatting
    - On-save behavior enabled except for filetypes with ambiguous conventions (C/C++)
    - Per-filetype formatter selection (e.g., Lua -> stylua; Python -> isort, black; JS/HTML/CSS -> prettier; YAML -> yamlfmt; Shell -> shfmt)
  - Telescope configuration with default pickers and keymaps for search/help/grep/diagnostics
  - Treesitter configuration with ensure_installed core set, highlight and indent settings
  - Finally, it auto-loads all modules under lua/custom/config via plenary.scandir, making that folder an extension point for local behavior

- Modular extensions: lua/custom/plugins/*.lua
  - tiny-inline-diagnostic.nvim (VeryLazy, high priority) — displays diagnostics inline; init.lua then disables native virtual_text to avoid duplication
  - neogit (with optional diffview/telescope/fzf/mini/snacks integrations) — enhanced Git UI
  - rustaceanvim — Rust tooling integration
  - avante.nvim — local AI assistant integration configured to use Ollama at http://localhost:11434 with model qwen2.5-coder:latest; note build step varies by OS (make BUILD_FROM_SOURCE=true on Unix, PowerShell build script on Windows)
  - Other optional plugin stubs are present in kickstart/plugins/* for reference but not necessarily enabled via lazy setup imports

- Local config glue: lua/custom/config/*.lua
  - avanti.lua sets vim.opt.laststatus = 3 (global statusline is required for fully collapsed views)
  - new-terminal.lua adds a convenience mapping <space>st: opens a vertical split terminal at bottom with fixed height
  - indentation.lua provides filetype-specific indentation settings for HTML, CSS, JS, Python, Lua and others

- Styling and formatting
  - .stylua.toml defines unified Lua style (2 spaces, prefer single quotes, column width 160); use stylua .

Operational notes for Warp
- First run in a new environment
  - Ensure external tools exist (git, make, unzip, ripgrep, a C compiler) before running any headless plugin sync commands
  - Run: nvim (interactive) or nvim --headless "+Lazy! sync" +qa to bootstrap lazy.nvim and plugins
  - Optionally force language tools install: nvim --headless "+MasonToolsInstall" +qa
  - Validate health: nvim --headless "+checkhealth" +qa
- Updating
  - Plugins: nvim --headless "+Lazy! update" +qa
  - Treesitter parsers: nvim --headless "+TSUpdateSync" +qa
- Formatting
  - Use stylua . for repository Lua code, and <leader>f inside Neovim for buffer-aware formatter routing via conform.nvim

Key bindings worth knowing (non-exhaustive, specific to this config)
- Formatting: <leader>f (conform.nvim)
- Telescope: <leader>sh (help), <leader>sf (files), <leader>sg (live grep), <leader>sd (diagnostics), <leader><leader> (buffers), <leader>/ (current buffer fuzzy)
- LSP: grn (rename), gra (code action), grr (references), gri (implementation), grd (definition), grD (declaration), gO/gW (document/workspace symbols), grt (type definition)
- Terminal convenience: <space>st (vertical split terminal at bottom)

Important excerpts from README.md
- Targets latest Neovim stable or nightly only
- External dependencies: git, make, unzip, C compiler, ripgrep; Nerd Font recommended
- Use :Lazy to inspect plugin status; :Mason to inspect tools

AI/assistant rule files
- No CLAUDE.md, Cursor rules, or Copilot instruction files were found in this repository at the time of writing.

