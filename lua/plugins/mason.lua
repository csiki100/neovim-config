return {
    'williamboman/mason.nvim',
    dependencies = {
        { 'neovim/nvim-lspconfig' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'Hoffs/omnisharp-extended-lsp.nvim' }
    },
    config = function()
        local on_attach = function()
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "qd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "qt", function() vim.lsp.buf.type_definition() end, opts)
            vim.keymap.set("n", "<leader>qh", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>qws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>qo", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "<leader>qn", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "<leader>qp", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>qc", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>qe", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>qr", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            vim.keymap.set("n", "<leader>qf", function() vim.lsp.buf.format() end, opts)
        end


        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        local default_setup = function(server)
            require('lspconfig')[server].setup({
                on_attach = on_attach,
                capabilities = lsp_capabilities,
            })
        end


        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                'angularls',
                'html',
                'cssls',
                'omnisharp',
                'lua_ls',
                'tsserver',
                'jsonls',
                'gopls',
            },
            handlers = {
                default_setup,
                lua_ls = function()
                    require('lspconfig').lua_ls.setup({
                        capabilities = lsp_capabilities,
                        on_attach = on_attach,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = {
                                        'vim'
                                    }
                                }
                            }
                        },
                    })
                end,
                omnisharp = function()
                    require('lspconfig').omnisharp.setup({
                        capabilities = lsp_capabilities,
                        on_attach = on_attach,
                    })
                end,
            },
        })
    end
}
