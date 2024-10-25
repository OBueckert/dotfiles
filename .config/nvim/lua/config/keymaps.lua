-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})

vim.api.nvim_set_keymap("n", "<C-k>", ":BufferLineCycleNext<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<C-j>", ":BufferLineCyclePrev<cr>", {silent = true, noremap = true})

vim.api.nvim_set_keymap("n", "<S-k>", ":BufferLineMoveNext<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<S-j>", ":BufferLineMovePrev<cr>", {silent = true, noremap = true})

vim.api.nvim_set_keymap("n", "<leader>bd", ":Bdelete<cr>", {silent = true, noremap = true})
