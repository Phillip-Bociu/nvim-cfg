return {
    cmd = {
        'W:\\llvm\\bin\\clangd.exe',
        '--enable-config',
    },
    filetypes = {"cpp", "c", "h", "hpp"},
    on_attach = function()
        require "lsp_signature".on_attach(signature_setup, bufnr)  -- Note: add in lsp client on-attach
    end
}

