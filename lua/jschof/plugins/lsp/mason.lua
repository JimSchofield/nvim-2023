-- Mason moved to the mason-org account, and v2 requires Neovim 0.11.
-- mason-lspconfig no longer wires servers into lspconfig itself; it calls
-- vim.lsp.enable() for whatever Mason has installed.
return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"cssls",
				"emmet_ls",
				"eslint",
				"gopls",
				"graphql",
				"html",
				"lua_ls",
				"svelte",
				"tailwindcss",
				"ts_ls",
			},
			-- Installed servers are enabled automatically. rust_analyzer is
			-- excluded because rustaceanvim starts and configures it itself;
			-- enabling it here too would attach two clients to every Rust buffer.
			automatic_enable = {
				exclude = { "rust_analyzer" },
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettier",
				"stylua",
			},
		})
	end,
}
