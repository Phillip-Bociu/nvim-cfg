vim.pack.add({
    'https://github.com/rafamadriz/friendly-snippets',
    { src = 'https://github.com/saghen/blink.compat', version = vim.version.range('2.x') },
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.x') },
})
require('blink.cmp').setup({
    keymap = {
        preset = 'default',
        ['<CR>'] = { 'select_and_accept', 'fallback' },
    },
    appearance = {
        nerd_font_variant = 'mono',
    },
    completion = { documentation = { auto_show = true } },
    sources = {
        default = { 'lsp', 'path', 'buffer', 'snippets' },
    },
    fuzzy = { implementation = "prefer_rust" },
})
