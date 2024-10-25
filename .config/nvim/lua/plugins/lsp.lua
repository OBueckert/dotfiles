return {
   'hrsh7th/nvim-cmp',
   dependencies = {
      'neovim/nvim-lspconfig',

      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',

      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
   },

   config = function()
      local signs = {
         Error = " ",
         Warn = " ",
         Hint = " ",
         Info = " "
      }

      for type, icon in pairs(signs) do
         local hl = "DiagnosticSign" .. type
         vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
      end

      -- Set up luasnip
      local ls = require("luasnip")

      vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

      vim.keymap.set({"i", "s"}, "<C-E>", function()
         if ls.choice_active() then
            ls.change_choice(1)
         end
      end, {silent = true})

      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("c", {
         s("fn", {
            i(1, "void"), t(' '), i(2, "name"), t('('), i(3, "void"), t(') {'),
            t({"", "\t"}), i(4),
            t({"", "}"})
         })
      })

      -- Set up nvim-cmp.
      local cmp = require'cmp'

      cmp.setup({
         snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
               require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end,
         },
         window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
         },
         mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
         }),
         sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' }, -- For luasnip users.
         }, {
            { name = 'buffer' },
         }),
         experimental = {
            ghost_text = true
         }
      })

      -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
      -- Set configuration for specific filetype.
      --[[ cmp.setup.filetype('gitcommit', {
         sources = cmp.config.sources({
            { name = 'git' },
         }, {
            { name = 'buffer' },
         })
      })
      require("cmp_git").setup() ]]-- 

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
         mapping = cmp.mapping.preset.cmdline(),
         sources = {
            { name = 'buffer' }
         }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
         mapping = cmp.mapping.preset.cmdline(),
         sources = cmp.config.sources({
            { name = 'path' }
         }, {
            { name = 'cmdline' }
         }),
         matching = { disallow_symbol_nonprefix_matching = false }
      })

      -- Set up lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      require('lspconfig')['ccls'].setup {
         capabilities = capabilities
      }

      vim.fn.sign_define(
      "LspDiagnosticsSignError",
      { texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError" }
      )
      vim.fn.sign_define(
      "LspDiagnosticsSignWarning",
      { texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning" }
      )
      vim.fn.sign_define(
      "LspDiagnosticsSignHint",
      { texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint" }
      )
      vim.fn.sign_define(
      "LspDiagnosticsSignInformation",
      { texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation" }
      )
   end,
}
