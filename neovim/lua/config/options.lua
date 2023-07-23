if vim.g.neovide then
  vim.o.guifont = "Monospace:h10"
  vim.g.neovide_cursor_animation_length = 0
end

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes:1"

vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "

_G.nvim = {}

function nvim.set_indent(ammount, use_spaces)
  use_spaces = use_spaces or true
  vim.opt.shiftwidth = ammount
  vim.opt.tabstop = ammount
  vim.opt.softtabsop = ammount
  vim.opt.expandtab = use_spaces
end

