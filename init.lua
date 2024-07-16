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
vim.opt.runtimepath:append("/some/path/to/store/parsers")
vim.wo.relativenumber = true
vim.wo.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.wo.wrap = false
vim.opt.makeprg = "build.bat"
vim.o.guifont = "JetBrainsMono Nerd Font:h16" 
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup('plugins')

