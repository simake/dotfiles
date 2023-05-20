--if vim.g.vscode then
  -- VSCode extension
  --require('vscode')
--else
  -- ordinary Neovim
  -- require('simon')
--end

-- Leader should be set before lazy setup
vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {})

require('keymaps')
require('colors')
