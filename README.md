# nvim

My Neovim config. Lua, [lazy.nvim](https://github.com/folke/lazy.nvim), Tokyo Night.

Requires Neovim >= 0.11.

## Install

```sh
git clone git@github.com:JimSchofield/nvim-2023.git ~/.config/nvim
nvim
```

lazy.nvim bootstraps itself on first launch and installs everything from
`lazy-lock.json`. Language servers and formatters come from Mason — run
`:Mason` to check on them, `:checkhealth` if something looks off.

## Layout

```
init.lua                 entry point
lua/jschof/
  core/                  options, keymaps, small utilities
  lazy.lua               plugin manager bootstrap
  plugins/               one file per plugin
    lsp/                 lspconfig + mason
after/ftplugin/          filetype overrides (rust)
```

Leader is `<Space>`.

## Keymaps

Only the non-obvious ones — `:Telescope keymaps` has the full list.

### Files & search

| Key          | Does                             |
| ------------ | -------------------------------- |
| `<leader>ff` | Find files                       |
| `<leader>rg` | Live grep                        |
| `<leader>fc` | Grep word under cursor           |
| `<leader>th` | Recent files (telescope history) |
| `<leader>ee` | Toggle file tree                 |
| `<leader>ef` | Toggle file tree on current file |

### Buffers

| Key                                     | Does                          |
| --------------------------------------- | ----------------------------- |
| `<Tab>` / `<S-Tab>`                     | Next / previous buffer        |
| `<leader>bb`                            | Buffer picker                 |
| `<leader>bd`                            | Delete buffer                 |
| `<leader>w` / `<leader>q` / `<leader>x` | Write / quit / write-and-quit |
| `<leader>cs`                            | Clear search highlight        |

### LSP

| Key                         | Does                               |
| --------------------------- | ---------------------------------- |
| `K`                         | Hover docs                         |
| `<leader>gd`                | Definitions                        |
| `gR`                        | References                         |
| `<leader>gi` / `<leader>gt` | Implementations / type definitions |
| `<leader>ca`                | Code actions (with preview)        |
| `<leader>sr`                | Rename                             |
| `<leader>d` / `<leader>D`   | Line / buffer diagnostics          |
| `<leader>[` / `<leader>]`   | Previous / next diagnostic         |
| `<leader>rs`                | Restart LSP                        |

### Git

| Key                          | Does              |
| ---------------------------- | ----------------- |
| `<leader>gs`                 | Status (fugitive) |
| `<leader>gc` / `<leader>gca` | Commit / amend    |
| `<leader>gb`                 | Blame             |

### Misc

| Key               | Does                                |
| ----------------- | ----------------------------------- |
| `<C-n>` / `<C-p>` | Move line or selection down / up    |
| `<leader>mp`      | Format buffer or range              |
| `<leader>gy`      | Goyo (distraction-free)             |
| `<leader>cfp`     | Copy current file path to clipboard |
| `<leader>vim`     | Open this config                    |

Panes are navigated with `<C-h/j/k/l>`, shared with tmux via
[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator).

## Notable behavior

- **Format on save** via conform.nvim — prettier for web files, stylua for
  Lua, LSP as fallback.
- **Mouse is off**, deliberately. `opt.mouse = ""` in `core/config.lua`.
- **No swapfiles**, but persistent undo is on, so history survives closing
  a file.
- **Rust** uses [rustaceanvim](https://github.com/mrcjkb/rustaceanvim), which
  overrides `K` and `<leader>ca` in Rust buffers with its own versions.

## Language servers

Installed via Mason: `ts_ls`, `eslint`, `html`, `cssls`, `tailwindcss`,
`graphql`, `emmet_ls`, `gopls`, `lua_ls`. Elixir uses `lexical`, which is
expected on `PATH` as `start_lexical.sh`.
