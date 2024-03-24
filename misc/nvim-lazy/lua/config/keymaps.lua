-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
-- vim.keymap.set("c", "jk", "C-c")
-- vim.keymap.set("c", "kj", "C-c")
-- vim.keymap.set("t", "jk", "<Esc>")
-- vim.keymap.set("t", "kj", "<Esc>")
-- TODO: Disabled because they mess with terminal mode and don't really work in command mode either

-- Prevent x and c from overwriting registers/clipboard
-- vim.keymap.set("n", "x", '"_x')
-- vim.keymap.set("v", "x", '"_x')
-- vim.keymap.set("c", "c", '"_c')
-- TODO: why no work?
