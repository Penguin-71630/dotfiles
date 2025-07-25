-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--- local Util = require("lazyvim.util")

--- Faster Cursor Navigation ---
vim.keymap.set({ "n", "v" }, "h", "b")
vim.keymap.set({ "n", "v" }, "l", "e")
vim.keymap.set({ "n", "v" }, "b", "l")
vim.keymap.set({ "n", "v" }, "e", "h")
vim.keymap.set({ "n", "v" }, "<C-h>", "^")
vim.keymap.set({ "n", "v" }, "<C-l>", "$")
vim.keymap.set({ "n", "v" }, "<C-k>", "5k")
vim.keymap.set({ "n", "v" }, "<C-j>", "5j")

--- File Saving ---
vim.keymap.set({ "n", "v" }, "<C-s>", "<Esc><Esc>:w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")
vim.keymap.set({ "n", "v", "i" }, "<C-q>", "<Esc><Esc>:wq<CR>")

--- Fix the problem that I always mistype ":" as ";" ---
vim.keymap.set("n", ";", ":")
