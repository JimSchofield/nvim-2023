return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- Applied to every server, so capabilities no longer have to be
		-- threaded through each one individually.
		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		-- Keymaps are set once, when a server attaches to a buffer, rather
		-- than being repeated in every server's on_attach.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("jschof_lsp_attach", { clear = true }),
			callback = function(event)
				local bufnr = event.buf

				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
				end

				map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
				map("n", "<leader>gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")
				map("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
				map("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
				map({ "n", "v" }, "<leader>ca", require("actions-preview").code_actions, "See available code actions")
				map("n", "<leader>sr", vim.lsp.buf.rename, "Smart rename")
				map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
				map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
				map("n", "<leader>[", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, "Go to previous diagnostic")
				map("n", "<leader>]", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, "Go to next diagnostic")
				map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
				map("i", "<C-k>", vim.lsp.buf.signature_help, "Show signature help")
				map("n", "<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if not client then
					return
				end

				if client:supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end

				-- Underline the symbol under the cursor and its other uses.
				if client:supports_method("textDocument/documentHighlight") then
					local group = vim.api.nvim_create_augroup("jschof_lsp_highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = group,
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = group,
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		-- Tear down this buffer's highlight autocmds when a server detaches,
		-- otherwise they keep firing for a client that is gone.
		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("jschof_lsp_detach", { clear = true }),
			callback = function(event)
				vim.lsp.buf.clear_references()
				pcall(vim.api.nvim_clear_autocmds, {
					group = "jschof_lsp_highlight",
					buffer = event.buf,
				})
			end,
		})

		vim.diagnostic.config({
			virtual_text = { prefix = "●", spacing = 4 },
			severity_sort = true,
			float = { border = "rounded", source = true },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "󰠠",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})

		-- Per-server overrides. Anything not listed here uses the defaults
		-- nvim-lspconfig ships in its `lsp/` directory, which now cover
		-- cmd, filetypes, and root markers.
		vim.lsp.config("eslint", {
			filetypes = {
				"astro",
				"css",
				"html",
				"javascript",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"typescript",
				"typescriptreact",
				"vue",
			},
		})

		vim.lsp.config("graphql", {
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		vim.lsp.config("emmet_ls", {
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- Built from source rather than installed through Mason, so it also
		-- needs enabling explicitly below.
		vim.lsp.config("lexical", {
			cmd = { "start_lexical.sh" },
			root_markers = { "mix.exs", ".git" },
		})

		-- mason-lspconfig only auto-enables servers that Mason installed.
		vim.lsp.enable("lexical")
	end,
}
