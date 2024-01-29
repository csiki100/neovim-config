require("default.remap")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup("plugins")

-- LSP-ZERO CONFIG
-- local cmp = require('cmp')
-- local cmp_action = require('lsp-zero').cmp_action()
--
-- require('luasnip.loaders.from_vscode').lazy_load()
--
-- cmp.setup({
--     sources = {
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' },
--     },
--     mapping = cmp.mapping.preset.insert({
--         -- `Enter` key to confirm completion
--         ['<CR>'] = cmp.mapping.confirm({ select = false }),
--
--         -- Ctrl+Space to trigger completion menu
--         ['<C-Space>'] = cmp.mapping.complete(),
--
--         -- Navigate between snippet placeholder
--         ['<C-f>'] = cmp_action.luasnip_jump_forward(),
--         ['<C-b>'] = cmp_action.luasnip_jump_backward(),
--
--         -- Scroll up and down in the completion documentation
--         ['<C-u>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-d>'] = cmp.mapping.scroll_docs(4),
--     })
-- })
--


-- VIM DEFAULT EDITOR SETTINGS

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
