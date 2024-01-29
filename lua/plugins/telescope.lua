
return    {
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
local telescopeBuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', telescopeBuiltin.find_files, {})
vim.keymap.set('n', '<leader>gf', telescopeBuiltin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    telescopeBuiltin.grep_string({ search = vim.fn.input("Grep > ") })
end)
        end
    }
