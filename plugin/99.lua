vim.pack.add({
    { src = 'https://github.com/saghen/blink.compat', version = vim.version.range('2.x') },
    'https://github.com/ThePrimeagen/99',
})

local _99 = require('99')

_99.setup({
    model = 'github-copilot/gpt-5.6-luna',
    completion = {
        source = 'blink',
    },
})

vim.keymap.set('v', '<leader>9v', _99.visual)
vim.keymap.set('n', '<leader>9s', _99.search)
vim.keymap.set('n', '<leader>9x', _99.stop_all_requests)
vim.keymap.set('n', '<leader>9m', function()
    require('99.extensions.telescope').select_model()
end)
vim.keymap.set('n', '<leader>9p', function()
    require('99.extensions.telescope').select_provider()
end)
