-- Function to copy current buffer contents to system clipboard
function Copy_buffer_path_to_clipboard()
	-- Get the file path of the current buffer
	local file_path = vim.api.nvim_buf_get_name(0)

	if file_path == "" then
		vim.notify("Buffer has no file path", vim.log.levels.WARN)
		return
	end

	-- Copy to system clipboard using the '+' register
	vim.fn.setreg("+", file_path)

	-- Show confirmation message with the path
	vim.notify("File path copied: " .. file_path, vim.log.levels.INFO)
end

-- Create a user command
vim.api.nvim_create_user_command("CopyBufferPath", Copy_buffer_path_to_clipboard, {
	desc = "Copy current buffer file path to system clipboard",
})

-- Optional: Create a key mapping (uncomment if desired)
vim.keymap.set("n", "<leader>cfp", Copy_buffer_path_to_clipboard, { desc = "Copy buffer to clipboard" })
