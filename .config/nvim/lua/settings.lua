vim.cmd(
  [[
  autocmd FileType lua setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType typescriptreact setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

]]
)

vim.api.nvim_set_keymap(
  'n', '<C-l>', ':noh<CR>', {noremap = true, nowait = true, silent = true}
)

-- eslint fix all on \F

vim.api.nvim_set_keymap(
  'n', '<leader>F', ':EslintFixAll<CR>', {silent = true, nowait = true}
)

vim.api.nvim_set_keymap(
  'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {
    silent = true,
    nowait = true
  }
)

vim.api.nvim_set_keymap(
  'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', {silent = true}
)

vim.diagnostic.config({virtual_text = false})

local set_code_style_condensed = function()
  local opts = {scope = "local"}
  vim.api.nvim_set_option_value('tabstop', 2, opts)
  vim.api.nvim_set_option_value('shiftwidth', 2, opts)
  vim.api.nvim_set_option_value('softtabstop', 2, opts)
end

vim.api.nvim_create_autocmd(
  {'FileType'}, {pattern = 'proto', callback = set_code_style_condensed}
)
vim.api.nvim_create_autocmd(
  {'FileType'}, {pattern = 'toml', callback = set_code_style_condensed}
)

vim.api.nvim_create_autocmd(
  {'BufWritePre'}, {
    pattern = 'rust',
    callback = function()
      vim.lsp.buf.formatting_sync(nil, 1000)
    end
  }
)
