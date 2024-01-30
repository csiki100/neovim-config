return {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
        require('Comment').setup({
            toggler = {
                line = '<leader>ql',
                block = '<leader>qb'
            },
            opleader = {
                line = 'ql',
                block = 'qb',
            },
        })
    end
}
