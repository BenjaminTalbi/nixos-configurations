-- Setup lspconfig
local nvim_lsp = require("lspconfig")
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function bug_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end
	
	-- Mappings
	local opts = {buffer = bufnr, remap = false}
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Enable Language Servers
local function default_lsp_setup(module)
	nvim_lsp[module].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

default_lsp_setup("tsserver")
default_lsp_setup("cssls")
default_lsp_setup("html")
default_lsp_setup("jsonls")
