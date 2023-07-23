local map = vim.keymap.set

-- Make Shift+Insert work in gui clients
if vim.g.neovide then
  map("i", "<S-Insert>", "<C-R>+", { silent = true })
end
