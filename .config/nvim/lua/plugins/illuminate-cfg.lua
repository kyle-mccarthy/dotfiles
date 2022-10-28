require('illuminate').configure({
  providers = {
    'treesitter',
    'regex',
    'lsp',
  },
  filetypes_denylist = {
    'dirbuf',
    'dirvish',
    'fugitive',
    'NvimTree'
  },
})
