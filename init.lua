require("kamski")

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

opt('o', 'hlsearch', false)
opt('o', 'incsearch', true)
opt('o', 'scrolloff', 8)
opt('o', 'sidescrolloff', 8 )

vim.opt.guicursor = ""

if vim.g.neovide then
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_scroll_animation_length = 0
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_hide_mouse_when_typing = true
end

vim.keymap.set('n', '<F9>', vim.cmd.make)

vim.lsp.set_log_level("off")
vim.opt.swapfile = false
vim.loader.enable()
