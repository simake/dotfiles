local lsp = require('lsp-zero')

lsp.preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})

  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, {buffer = true})
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = true})
end)

lsp.ensure_installed({
  'lua_ls',
  'tsserver',
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require('cmp')

--local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_select = {behavior = cmp.SelectBehavior.Insert}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm(),
    --['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
})
cmp.setup({
  mapping = cmp_mappings,
  completion = {
    completeopt = 'menu,menuone,noselect'
  }
})

