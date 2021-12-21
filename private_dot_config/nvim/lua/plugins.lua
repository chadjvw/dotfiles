local present, packer = pcall(require, 'packer')

if present then
    packer = require 'packer'
else
    return
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local use = packer.use

local compile_path = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua'

if vim.fn.has('macunix') == 1 then
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua'
end

return packer.startup({
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
        use '9mm/vim-closer'

        -- Lazy loading:
        -- Load on specific commands
        use {
            'tpope/vim-dispatch',
            opt = true,
            cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
        }

        -- Load on an autocommand event
        use 'andymass/vim-matchup'

        local treesitter_branch = 'master'

        if vim.fn.has('macunix') == 1 then
            treesitter_branch = '0.5-compat'
        end

        use {
            'nvim-treesitter/nvim-treesitter',
            branch = treesitter_branch,
            requires = 'nvim-treesitter/nvim-treesitter-refactor',
            run = ':TSUpdate',
            config = function()
                require 'plugins.treesitter'
            end
        }

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

        use 'sainnhe/gruvbox-material'

        use {
            'gelguy/wilder.nvim',
            requires = {'nixprime/cpsm', 'romgrk/fzy-lua-native'}
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
            requires = {{
                'hrsh7th/cmp-nvim-lsp',
                after = 'nvim-cmp'
            }, {
                'hrsh7th/cmp-buffer',
                after = 'nvim-cmp'
            }, {
                'hrsh7th/cmp-path',
                after = 'nvim-cmp'
            }, {
                'dcampos/cmp-snippy',
                after = 'nvim-cmp'
            }, 'dcampos/nvim-snippy', 'honza/vim-snippets'},
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
    end,
    config = {
        profile = {
            enable = true
        },
        display = {
            open_fn = function()
                return require('packer.util').float({
                    border = 'single'
                })
            end
        },
        -- Move to lua dir so impatient.nvim can cache it
        compile_path = compile_path
    }
})
