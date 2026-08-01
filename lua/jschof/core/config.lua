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
opt.wrap = true

-- case
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- swap
opt.swapfile = false

-- Undo survives closing the file. Matters more with swapfiles off,
-- since there's otherwise no recovery at all.
opt.undofile = true
opt.undolevels = 10000

-- list chars
opt.list = true
opt.listchars = { tab = "❘ ", multispace = "| ", trail = "×", extends = "»", nbsp = "×" }

-- Turn off Mouse
opt.mouse = ""

-- Keep context visible around the cursor instead of letting it sit
-- against the top or bottom edge.
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Wrapped lines keep their indentation, so wrapped code stays readable.
opt.breakindent = true

-- Splits open where the eye expects them.
opt.splitright = true
opt.splitbelow = true

-- Reserve the sign column so text doesn't jump sideways when a
-- diagnostic or git sign appears.
opt.signcolumn = "yes"

-- Faster CursorHold, which drives LSP document highlight.
opt.updatetime = 250

-- Don't make me wait a full second to finish a leader sequence.
opt.timeoutlen = 400

-- Prompt to save instead of erroring out on :q with unsaved changes.
opt.confirm = true

-- Live preview of :substitute in a split.
opt.inccommand = "split"

-- Briefly highlight yanked text, so it's obvious what got copied.
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	callback = function()
		vim.hl.on_yank({ timeout = 150 })
	end,
})
