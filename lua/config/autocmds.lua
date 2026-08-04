vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd('VimEnter', {
    desc = 'Force an initial repaint to avoid a blank screen on startup',
    group = vim.api.nvim_create_augroup('startup-redraw', { clear = true }),
    once = true,
    callback = function()
        vim.schedule(function()
            vim.cmd('redraw!')
        end)
    end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
    desc = 'Run clang-format before writing C/C++ buffers',
    group = vim.api.nvim_create_augroup('clang-format-on-save', { clear = true }),
    pattern = { '*.c', '*.cc', '*.cpp', '*.cxx', '*.h', '*.hh', '*.hpp', '*.hxx' },
    callback = function(args)
        local filename = vim.api.nvim_buf_get_name(args.buf)
        local escaped = vim.fn.shellescape(filename)
        local view = vim.fn.winsaveview()
        vim.cmd('silent keepjumps %!clang-format --assume-filename=' .. escaped)
        vim.fn.winrestview(view)
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("jenkinsfile_detect", { clear = true }),
    pattern = { "Jenkinsfile", "jenkinsfile", "*.jenkinsfile" },
    callback = function()
        vim.bo.filetype = "groovy"
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        local methods = vim.lsp.protocol.Methods;

        -- defaults:
        -- https://neovim.io/doc/user/news-0.11.html#_defaults

        map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gr", vim.lsp.buf.references, "List References")
        vim.keymap.set('i', '<CR>', function()
            return vim.fn.pumvisible() == 1 and '<C-y' or '<CR>'
        end, { expr = true })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client:supports_method(methods.textDocument_completion) then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = false })
        end
    end,
})
