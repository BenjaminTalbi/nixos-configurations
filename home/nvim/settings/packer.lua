-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'mbbill/undotree'
    use 'ellisonleao/gruvbox.nvim'
    use({ 'rose-pine/neovim', as = 'rose-pine' })
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use({
        'nvim-treesitter/nvim-treesitter-context',
        after = "nvim-treesitter",
        requires = "nvim-treesiter/nvim-treesitter",
    })
    use({
        "windwp/nvim-ts-autotag",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use('theprimeagen/harpoon')
    use('tpope/vim-fugitive')
    use('rbong/vim-flog')
    use('jremmen/vim-ripgrep')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })
    use({
        'euclio/vim-markdown-composer',
        run = "cd ~/.local/share/nvim/site/pack/packer/start/vim-markdown-composer && cargo build --release", --curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        config = function()
            vim.g.markdown_composer_autostart = 0
        end
    })
    use {
        'laytan/tailwind-sorter.nvim',
        requires = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        run = 'cd formatter && npm i && npm run build',
    }
end)
