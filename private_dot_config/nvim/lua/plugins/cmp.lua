local present, cmp = pcall(require, "cmp")

if not present then
   return
end

cmp.setup({
    snippet = {
        expand = function(args)
            require'snippy'.expand_snippet(args.body)
        end
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            select = true
        })
    },
    sources = {{
        name = 'nvim_lsp'
    }, {
        name = 'path'
    }, {
        name = 'snippy'
    }, {
        name = 'buffer'
    }}
})
