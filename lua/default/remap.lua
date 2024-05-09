vim.g.mapleader = ' '
vim.o.equalalways = false
vim.keymap.set("n", "<leader>ep", vim.cmd.Ex)
vim.keymap.set("n", "<leader>te", ":below split | resize 15 | terminal<CR>")
vim.keymap.set("n", "<leader>tr", ":resize 20<CR>")

vim.keymap.set("n", "H", "<C-W>h")
vim.keymap.set("n", "J", "<C-W>j")
vim.keymap.set("n", "K", "<C-W>k")
vim.keymap.set("n", "L", "<C-W>l")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>P", "\"_dP")
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.api.nvim_set_keymap('t', '<leader>tn', '<C-\\><C-n>', { noremap = true })

