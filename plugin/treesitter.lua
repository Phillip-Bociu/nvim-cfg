vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
        if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
        vim.cmd('TSUpdate')
    end
end })

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
    once = true,
    callback = function()
        vim.pack.add({
            'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
            { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
        })
        require("nvim-treesitter.configs").setup({
            sync_install = false,
            ignore_install = { "javascript" },
            modules = {},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            auto_install = true,
            ensure_installed = {
                "c",
                "cpp",
                "cmake",
            },
        })
    end,
})
