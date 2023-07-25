local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gT", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vj", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>vk", function() vim.diagnostic.goto_prev() end, opts)
    --	vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

require('lspconfig').tsserver.setup {
    on_attach = on_attach
}

require('lspconfig').lua_ls.setup {
    on_attach = on_attach
}

vim.diagnostic.config({
    virtual_text = true
})

-- Setup tiny spinner while lsp is working
-- require("fidget").setup {}

-- Setting vim values
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Setup nvim-cmp
local cmp = require('cmp')
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
        ['<C-y>'] = cmp.mapping.complete()
    }
})
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}
-- local cmp_mappings = lsp.defaults.cmp_mappings({
-- 	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
-- 	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
-- 	['<C-Space>'] = cmp.mapping.confirm({ select = true }),
-- 	['<C-y>'] = cmp.mapping.complete()
-- })
-- local lsp = require('lsp-zero')
--
-- lsp.preset('recommended')
--
-- lsp.ensure_installed({
-- 	'tsserver',
-- })
--
--
-- --lsp.set_preferences({
-- --	sign_icons = {	}
-- --})
--
-- lsp.setup_nvim_cmp({
-- 	mapping = cmp_mappings
-- })
--
--
-- lsp.setup_servers({
--     'tsserver',
--     'eslint',
--     'nil'
-- })
-- lsp.setup()
--
