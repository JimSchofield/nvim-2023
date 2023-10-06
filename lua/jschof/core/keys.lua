local keymap = vim.keymap

-- Clear search
keymap.set('n', '<leader>cs', ':noh<CR>', { desc = "Clear search" })


-- File niceties
keymap.set('n', '<leader>q', ':q<CR>', { desc = "Quit" })
keymap.set('n', '<Leader>w', ':w<CR>', { desc = "Save" })
keymap.set('n', '<Leader>s', ':source ~/.config/nvim/init.lua<CR>', { desc = "Source" })
keymap.set('n', '<leader>vim', ':tabe ~/.config/nvim/<CR>' , { desc = "Open NVim config" })
keymap.set('n', '<leader>x', ':x<CR>' , { desc = "Save and close" })

-- Explore
keymap.set('n', '<leader>e', ':Explore<CR>' , { desc = "Explorer with netrw" })

-- Fugitive
keymap.set('n', '<leader>gs', ':Git<CR>' , { desc = "Git status" })
keymap.set('n', '<leader>gc', ':Git commit<CR>' , { desc = "Git commit" })
keymap.set('n', '<leader>gca', ':Git commit --amend<CR>' , { desc = "Git commit ammend" })
keymap.set('n', '<leader>gb', ':Git blame<CR>' , { desc = "Git blame" })

-- Move selection
-- Moving lines with option-j/k
keymap.set('n', '<C-J>', ':m .+1<CR>==', { desc = "Move selection down 1"})
keymap.set('n', '<C-K>', ':m .-2<CR>==', { desc = "Move selection up 1"})
keymap.set('v', '<C-J>', ":m '>+1<CR>gv=gv", { desc = "Move selection down 1"})
keymap.set('v', '<C-K>', ":m '<-2<CR>gv=gv", { desc = "Move selection up 1"})

