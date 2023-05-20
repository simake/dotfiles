local vscode = vim.g.vscode == 1

if not vscode then
  vim.cmd.colorscheme("kanagawa")
  -- vim.cmd.colorscheme("vscode")
end

