print('hello')

if vim.g.vscode then
  -- VSCode extension
  require('vscode')
else
  -- ordinary Neovim
  require('simon')
end

