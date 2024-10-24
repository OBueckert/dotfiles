return require('packer').startup(function(use)

   use 'wbthomason/packer.nvim'

   use 'navarasu/onedark.nvim'
   require('onedark').load()

   use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
   }

   use {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
   }

   use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
   }

   use 'neovim/nvim-lspconfig'
   use 'hrsh7th/cmp-nvim-lsp'
   use 'hrsh7th/cmp-buffer'
   use 'hrsh7th/cmp-path'
   use 'hrsh7th/cmp-cmdline'
   use 'hrsh7th/nvim-cmp'

   use 'L3MON4D3/LuaSnip'
   use 'saadparwaiz1/cmp_luasnip'

end)
