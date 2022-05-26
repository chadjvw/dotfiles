local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
                                  install_path})
end

local packer_group = vim.api.nvim_create_augroup('Packer', {
    clear = true
})

vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    pattern = 'init.lua'
})

return require('packer').startup({
    function()
        use 'lewis6991/impatient.nvim'

        use {
            'b3nj5m1n/kommentary',
            config = function()
                require 'plugins.kommentary'
            end
        }
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'

        -- Simple plugins can be specified as strings
        use {
            'windwp/nvim-autopairs',
            config = function()
                require('nvim-autopairs').setup {}
            end
        }

        -- Lazy loading:
        -- Load on specific commands
        use {
            'tpope/vim-dispatch',
            opt = true,
            cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
        }

        -- Load on an autocommand event
        use 'andymass/vim-matchup'

        use {
            'nvim-treesitter/nvim-treesitter',
            requires = 'nvim-treesitter/nvim-treesitter-refactor',
            run = ':TSUpdate',
            config = function()
                require 'plugins.treesitter'
            end
        }

        -- use {
        --     'IndianBoy42/tree-sitter-just',
        --     requires = 'nvim-treesitter/nvim-treesitter',
        --     config = function()
        --         require'tree-sitter-just'.setup {}
        --     end
        -- }

        use {
            'nvim-lualine/lualine.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                require 'plugins.lualine'
            end
        }

        use {
            'lewis6991/gitsigns.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = function()
                require 'plugins.gitsigns'
            end
        }

        use 'ellisonleao/gruvbox.nvim'

        use {
            "catppuccin/nvim",
            as = "catppuccin"
        }

        use {
            'gelguy/wilder.nvim',
            requires = {'nixprime/cpsm', 'romgrk/fzy-lua-native'},
            config = function()
                require 'plugins.wilder'
            end
        }

        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                require 'plugins.nvim-tree'
            end
        }

        use {
            'williamboman/nvim-lsp-installer',
            requires = {'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp'},
            config = function()
                require 'plugins.lspconfig'
            end
        }

        -- Completion
        use {
            'hrsh7th/nvim-cmp',
            requires = {'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-nvim-lsp-signature-help', 'hrsh7th/cmp-buffer',
                        'hrsh7th/cmp-path', 'dcampos/cmp-snippy', 'dcampos/nvim-snippy', 'honza/vim-snippets'},
            config = function()
                require 'plugins.cmp'
            end
        }

        use 'lukas-reineke/indent-blankline.nvim'

        use {
            'karb94/neoscroll.nvim',
            config = function()
                require('neoscroll').setup()
            end
        }

        use {
            "folke/which-key.nvim",
            config = function()
                require('which-key').setup()
            end
        }

        use 'folke/lsp-colors.nvim'

        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require('trouble').setup()
            end
        }

        use {
            "j-hui/fidget.nvim",
            config = function()
                require('fidget').setup()
            end
        }

        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = {}
})
