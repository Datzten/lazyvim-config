-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.wrap = true
-- Alternar entre buffers com TAB e Shift+TAB
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Próxima aba (buffer)" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Aba anterior (buffer)" })
