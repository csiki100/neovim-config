return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        local configs = require("catppuccin")
        configs.setup({
            integrations={
                harpoon=true
            },
            transparent_background=true,
            -- dim_inactive = {
            --     enabled = true,
            -- },

        })
        vim.cmd.colorscheme "catppuccin"
    end
}
