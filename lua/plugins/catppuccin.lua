return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        local configs = require("catppuccin")
        configs.setup({
            dim_inactive = {
                enabled = true
            },
            integrations={
                harpoon=true
            },
            transparent_background=true

        })
        vim.cmd.colorscheme "catppuccin"
    end
}
