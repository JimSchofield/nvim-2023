local keymap = vim.keymap

-- Clear search
keymap.set("n", "<leader>cs", ":noh<CR>", { desc = "Clear search" })

-- File niceties
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<Leader>w", ":w<CR>", { desc = "Save" })
keymap.set("n", "<leader>vim", ":tabe ~/.config/nvim/<CR>", { desc = "Open NVim config" })
keymap.set("n", "<leader>x", ":x<CR>", { desc = "Save and close" })

-- Explore
-- keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Explorer with netrw" })

-- Fugitive
keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
keymap.set("n", "<leader>gca", ":Git commit --amend<CR>", { desc = "Git commit ammend" })
keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })

-- Move selection
keymap.set("n", "<C-n>", ":m .+1<CR>==", { desc = "Move selection down 1" })
keymap.set("n", "<C-p>", ":m .-2<CR>==", { desc = "Move selection up 1" })
keymap.set("v", "<C-n>", ":m '>+1<CR>gv=gv", { desc = "Move selection down 1" })
keymap.set("v", "<C-p>", ":m '<-2<CR>gv=gv", { desc = "Move selection up 1" })
