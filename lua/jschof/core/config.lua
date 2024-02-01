local opt = vim.opt

-- default system clipboard
opt.clipboard:append("unnamedplus")

-- show commands
vim.opt.showcmd = true

-- line numbers
opt.number = true

-- tabs
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrap
opt.wrap = false

-- case
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- clipboard
-- opt.clipboard:append("unnamedplus")

-- swap
opt.swapfile = false

-- list chars
opt.list = true
opt.listchars = { tab = "❘ ", multispace = "| ", trail = "×", extends = "»", nbsp = "×" }

-- Turn off Mouse
opt.mouse = ""
