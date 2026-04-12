---@brief
---
--- https://github.com/regen100/cmake-language-server
---
--- CMake LSP Implementation

---@type vim.lsp.Config

return {
    cmd = { 'neocmakelsp', 'stdio' },
    filetypes = { 'cmake' },
    root_markers = { '.neocmake.toml', '.git', 'build', 'cmake' },
}

