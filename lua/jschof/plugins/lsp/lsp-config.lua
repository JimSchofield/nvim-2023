return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap

		local function map(mode, lhs, rhs, desc, bufnr)
			keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
		end

		local on_attach = function(client, bufnr)
			map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references", bufnr)
			map("n", "<leader>gD", vim.lsp.buf.declaration, "Go to declaration", bufnr)
			map("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions", bufnr)
			map("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations", bufnr)
			map("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions", bufnr)
			map({ "n", "v" }, "<leader>ca", require("actions-preview").code_actions, "See available code actions", bufnr)
			map("n", "<leader>sr", vim.lsp.buf.rename, "Smart rename", bufnr)
			map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics", bufnr)
			map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics", bufnr)
			map("n", "<leader>[", function() vim.diagnostic.jump({ count = -1 }) end, "Go to previous diagnostic", bufnr)
			map("n", "<leader>]", function() vim.diagnostic.jump({ count = 1 }) end, "Go to next diagnostic", bufnr)
			map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor", bufnr)
			map("i", "<C-k>", vim.lsp.buf.signature_help, "Show signature help", bufnr)
			map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP", bufnr)

			-- Enable inlay hints if supported
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end

			-- Enable document highlight on cursor hold
			if client.server_capabilities.documentHighlightProvider then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = bufnr,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd("CursorMoved", {
					buffer = bufnr,
					callback = vim.lsp.buf.clear_references,
				})
			end
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Configure diagnostic display
		vim.diagnostic.config({
			virtual_text = { prefix = "●", spacing = 4 },
			severity_sort = true,
			float = { border = "rounded", source = true },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "󰠠",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})

		-- configure html server
		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure typescript server with plugin
		lspconfig["ts_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

	
		-- configure eslint server
		lspconfig["eslint"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
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

		-- configure css server
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure tailwindcss server
		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.lexical.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "start_lexical.sh" },
			filetypes = { "elixir", "eelixir", "heex", "surface" },
			root_dir = function(fname)
				return lspconfig.util.root_pattern("mix.exs")(fname)
					or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
			end,
			single_file_support = true,
		})

		-- configure graphql language server
		lspconfig["graphql"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		-- configure emmet language server
		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end,
}
