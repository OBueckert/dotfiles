return {
   'akinsho/bufferline.nvim',
   version = "*",
   dependencies = 'nvim-tree/nvim-web-devicons',
   config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup{
         options = {
            diagnostics = "nvim_lsp"
         }
      }
      vim.cmd([[
      hi BufferLineIndicatorSelected guifg='#61afef'
      hi BufferLineFill guibg=bg
      ]])
   end,
}
