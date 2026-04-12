if vim.loader then
	vim.loader.enable()
end

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

opt('o', 'hlsearch', false)
opt('o', 'incsearch', true)
opt('o', 'scrolloff', 8)
opt('o', 'sidescrolloff', 8 )
opt('o', 'sidescrolloff', 8 )

vim.o.cindent = true
vim.o.cino = 'j1,(0,ws,Ws,l1'
vim.opt.guicursor = ""

vim.g.have_nerd_font = false
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.wo.relativenumber = true
vim.wo.number = true
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.winborder = 'rounded'
vim.wo.wrap = false
vim.opt.makeprg = "u.cmd"
vim.o.guifont = "JetBrainsMono Nerd Font:h16" 
vim.g.mapleader = " "
vim.g.maplocalleader = ","

