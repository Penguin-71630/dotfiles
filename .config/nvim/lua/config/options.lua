-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here


local opt = vim.opt

opt.shiftround = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true -- 用空格代替 Tab
vim.o.shiftwidth = 4   -- 每層縮排的空格數
vim.o.tabstop = 4      -- Tab 顯示為 4 個空格

opt.wrap = true
