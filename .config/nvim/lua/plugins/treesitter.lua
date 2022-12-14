require('nvim-treesitter.configs').setup(
  {
    ensure_installed = { 'rust', 'typescript', 'lua', 'html', 'bash', 'proto', 'dockerfile', 'markdown_inline', 'graphql',
      'tsx', 'json', 'prisma', 'json5', 'vim', 'sql', 'regex', 'comment', 'query', 'javascript', 'yaml', 'markdown' },
    highlight = { enable = true },
    -- incremental_selection = {enable = true},
    indent = { enable = true, disable = { "python" } },
    matchup = { enable = true },
    rainbow = {
      enable = true,
      extended_mode = true,
      disable = { "tsx" }
    },
    spell = { enabled = true },
  }
)

require('spellsitter').setup()
