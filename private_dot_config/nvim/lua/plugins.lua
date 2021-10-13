-- This file can be loaded by calling `lua require('plugins')` from your init.vim
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
    config = {
        -- Move to lua dir so impatient.nvim can cache it
        compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua'
    }

    use 'lewis6991/impatient.nvim'
    use 'b3nj5m1n/kommentary'
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Simple plugins can be specified as strings
    use '9mm/vim-closer'

    -- Lazy loading:
    -- Load on specific commands
    use {
        'tpope/vim-dispatch',
        opt = true,
        cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
    }

    -- Load on an autocommand event
    use {
        'andymass/vim-matchup',
        event = 'VimEnter'
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ignore_install = {'haskell'},
                ensure_installed = 'maintained',
                highlight = {
                    enable = true,
                    disable = {}
                }
            }
        end
    }

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function()
            require'lualine'.setup {
                options = {
                    theme = 'gruvbox',
                    section_separators = '',
                    component_separators = ''
                }
            }
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('gitsigns').setup {
                signs = {
                    add = {
                        hl = 'GreenSign',
                        text = '│',
                        numhl = 'GitSignsAddNr'
                    },
                    change = {
                        hl = 'BlueSign',
                        text = '│',
                        numhl = 'GitSignsChangeNr'
                    },
                    delete = {
                        hl = 'RedSign',
                        text = '│',
                        numhl = 'GitSignsDeleteNr'
                    },
                    topdelete = {
                        hl = 'RedSign',
                        text = '│',
                        numhl = 'GitSignsDeleteNr'
                    },
                    changedelete = {
                        hl = 'PurpleSign',
                        text = '│',
                        numhl = 'GitSignsChangeNr'
                    }
                },
                keymaps = {}
            }
        end
    }

    use 'sainnhe/gruvbox-material'
    use {
        'gelguy/wilder.nvim',
        requires = {'nixprime/cpsm', 'romgrk/fzy-lua-native'},
        keys = ':',
        config = function()
            vim.cmd [[silent! call wilder#enable_cmdline_enter()]]
            vim.cmd [[set wildcharm=<Tab>]]
            vim.cmd [[cnoremap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"]]
            vim.cmd [[cnoremap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"]]
            -- only / and ? are enabled by default
            vim.cmd [[call wilder#set_option('modes', ['/', '?', ':'])]]
            vim.cmd [[call wilder#set_option('use_python_remote_plugin', 0)]]
            -- When the cmdline is empty, provide suggestions based on the cmdline history
            vim.cmd [[call wilder#set_option('pipeline', [
                \   wilder#branch(
                \     wilder#python_file_finder_pipeline({
                \       'file_command': {_, arg -> stridx(arg, '.') != -1 ? ['fd', '-tf', '-H'] : ['fd', '-tf']},
                \       'dir_command': ['fd', '-td'],
                \       'filters': ['cpsm_filter'],
                \     }),
                \     wilder#substitute_pipeline({
                \       'pipeline': wilder#python_search_pipeline({
                \         'skip_cmdtype_check': 1,
                \         'pattern': wilder#python_fuzzy_pattern({
                \           'start_at_boundary': 0,
                \         }),
                \       }),
                \     }),
                \     wilder#cmdline_pipeline({
                \       'fuzzy': 1,
                \       'fuzzy_filter': has('nvim') ? wilder#lua_fzy_filter() : wilder#vim_fuzzy_filter(),
                \     }),
                \     [
                \       wilder#check({_, x -> empty(x)}),
                \       wilder#history(),
                \     ],
                \     wilder#python_search_pipeline({
                \       'pattern': wilder#python_fuzzy_pattern({
                \         'start_at_boundary': 0,
                \       }),
                \     }),
                \   ),
                \ ])]]
            -- popupmenu completion
            vim.cmd [[call wilder#set_option('renderer', wilder#popupmenu_renderer({
            \ 'highlighter': wilder#lua_fzy_highlighter(),
            \ 'border': 'rounded',
            \ 'empty_message': wilder#popupmenu_empty_message_with_spinner(),
            \ 'left': [
            \   ' ', wilder#popupmenu_devicons(),
            \ ],
            \ 'right': [
            \   ' ', wilder#popupmenu_scrollbar(),
            \ ],
            \ }))]]
        end
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
            vim.g.nvim_tree_gitignore = 1
            vim.g.nvim_tree_indent_markers = 1
            vim.g.nvim_tree_git_hl = 1
            vim.g.nvim_tree_highlight_opened_files = 1
            vim.cmd [[let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 }]]
            vim.cmd [[let g:nvim_tree_show_icons = {
                \ 'git': 1,
                \ 'folders': 1,
                \ 'files': 1,
                \ 'folder_arrows': 1,
                \ }]]

            require'nvim-tree'.setup {
                -- open the tree when running this setup function
                open_on_setup = true,
                -- closes neovim automatically when the tree is the last **WINDOW** in the view
                auto_close = true,
                -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
                open_on_tab = true
            }
        end
    }

    use {
        'kabouzeid/nvim-lspinstall',
        requires = 'neovim/nvim-lspconfig',
        config = function()
            local function setup_servers()
                require'lspinstall'.setup()
                local servers = require'lspinstall'.installed_servers()
                for _, server in pairs(servers) do
                    require'lspconfig'[server].setup {
                        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol
                                                                                       .make_client_capabilities())
                    }
                end
            end

            setup_servers()

            -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
            require'lspinstall'.post_install_hook = function()
                setup_servers() -- reload installed servers
                vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
            end
        end
    }

    -- Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {'L3MON4D3/LuaSnip', {
            'hrsh7th/cmp-buffer',
            after = 'nvim-cmp'
        }, 'hrsh7th/cmp-nvim-lsp', {
            'hrsh7th/cmp-path',
            after = 'nvim-cmp'
        }, {
            'hrsh7th/cmp-nvim-lua',
            after = 'nvim-cmp'
        }, {
            'saadparwaiz1/cmp_luasnip',
            after = 'nvim-cmp'
        }},
        config = function()
            -- Setup nvim-cmp.
            local cmp = require 'cmp'

            cmp.setup({
                snippet = {
                    expand = function(args)
                        -- For `vsnip` user.
                        vim.fn["vsnip#anonymous"](args.body)

                        -- For `luasnip` user.
                        -- require('luasnip').lsp_expand(args.body)

                        -- For `ultisnips` user.
                        -- vim.fn["UltiSnips#Anon"](args.body)
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
                }, -- For vsnip user.
                {
                    name = 'vsnip'
                }, -- For luasnip user.
                -- { name = 'luasnip' },
                -- For ultisnips user.
                -- { name = 'ultisnips' },
                {
                    name = 'buffer'
                }}
            })
        end,
        event = 'InsertEnter *'
    }

    use {
        "danymat/neogen",
        config = function()
            require('neogen').setup {
                enabled = true
            }
        end,
        requires = "nvim-treesitter/nvim-treesitter"
    }
end)
