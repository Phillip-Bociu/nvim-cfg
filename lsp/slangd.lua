return {
    cmd = { 'slangd' },
    filetypes = { 'shaderslang' },
    root_markers = { '.git' },
    settings = {
        slang = {
            inlayHints = {
                deducedTypes = true,
                parameterNames = true,
            }
        }
    },
}
