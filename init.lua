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


require("lazy").setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            local configs = require("catppuccin")
            configs.setup({
                dim_inactive = {
                    enabled = true
                }
            })
        end
    },

    "hiphish/rainbow-delimiters.nvim",

    { 'numToStr/Comment.nvim', lazy = false },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "html", "css", "scss", "python" },
                sync_install = false,
                highlight = { enable = true, additional_vim_regex_highlighting = true },
                indent = { enable = true },
            })
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    file_ignore_patterns = { "node_modules" }
                }
            })
        end
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    "mbbill/undotree",

    "tpope/vim-fugitive",

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/nvim-cmp' },
            {
                'L3MON4D3/LuaSnip',
                dependencies = {
                    { "rafamadriz/friendly-snippets" },
                    { 'saadparwaiz1/cmp_luasnip' }
                },
            },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        }
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    --{
    --    "pmizio/typescript-tools.nvim",
    --    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    --    opts = {},
    --}
})

-- CATPPUCCIN CONFIG
vim.cmd.colorscheme "catppuccin"


-- TELESCOPE CONFIG
local telescopeBuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', telescopeBuiltin.find_files, {})
vim.keymap.set('n', '<leader>gf', telescopeBuiltin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    telescopeBuiltin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- HARPOON CONFIG
local harpoon = require("harpoon")

-- required
harpoon:setup()
-- required

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-b>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-m>", function() harpoon:list():select(3) end)

-- UNDOTREE CONFIG
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- FUGITIVE CONFIG
vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

-- LSP-ZERO CONFIG
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "qd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>qh", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>qws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>ql", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>qn", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>qp", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>qc", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>qe", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>qr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>qf", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'angularls',
        'html',
        'cssls',
        'omnisharp',
        'lua_ls',
        'tsserver',
        'pyright'
    },
    handlers = {
        lsp_zero.default_setup,
    },
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})




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
