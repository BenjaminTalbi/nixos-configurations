local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
	snippet = { 
		expand = function(args) 
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {},
	mappings = cmp.mapping.preset.insert({
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete()
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	}, 
	{
		{ name = 'buffer' }
	})
})
