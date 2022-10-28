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

local map = vim.api.nvim_set_keymap
local options = {noremap = true, silent = false}

map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
-- map('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', options)
-- map('n', '<C-p>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', options)

vim.api.nvim_create_user_command(
  'ShowError', function()
    local max_width = math.floor((40 * 2) * (vim.o.columns / (40 * 2 * 16 / 9)))
    vim.diagnostic.open_float(
      {
        focusable = false,
        max_width = max_width,
        border = "rounded",
        winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None'
      }
    )
  end, {}
)

map('n', '<leader>e', '<cmd>ShowError<CR>', options)

-- cosmetics
vim.fn.sign_define(
  'DiagnosticSignError', {text = '', texthl = 'DiagnosticSignError'}
) -- error
vim.fn.sign_define(
  'DiagnosticSignWarning', {text = '', texthl = 'DiagnosticSignWarning'}
) -- warning
vim.fn.sign_define(
  'DiagnosticSignHint', {text = '', texthl = 'DiagnosticSignHint'}
) -- hint
vim.fn.sign_define(
  'DiagnosticSignInformation', {text = '', texthl = 'DiagnosticInformation'}
) -- information

-- formatting
vim.api.nvim_command([[command! -nargs=0 Format :lua vim.lsp.buf.format { async = false }]])
vim.api.nvim_command([[command! -nargs=0 Fmt :lua vim.lsp.buf.format { async = false }]])
vim.api.nvim_set_keymap(
  'n', '<leader>f', '<cmd>lua vim.lsp.buf.format { async = false }<CR>',
  {noremap = true, silent = true, nowait = true}
)

