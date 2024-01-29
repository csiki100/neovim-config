return     {
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
    }
