local cmp = require 'cmp'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

cmp.setup(
  {
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end
    },
    mapping = cmp.mapping.preset.insert(
      {
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-y>'] = cmp.config.disable,
        ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close()
        }),
        ['<CR>'] = cmp.mapping.confirm(
          {select = false, behavior = cmp.ConfirmBehavior.Replace}
        ),
        ['<Tab>'] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.complete()
            else
              fallback()
            end
          end
        ),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'})
      }
    ),
    sources = cmp.config.sources(
      {
        {name = 'copilot'},
        {name = 'nvim_lsp'},
        {name = 'cmp_tabnine'},
        {name = 'path'},
        {name = 'luasnip'},
        {name = 'buffer'}
      }
    ),
    -- view = {entries = 'native'},
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered()
    },
    formatting = {
      format = require("lspkind").cmp_format(
        {
          with_text = true,
          menu = ({
            buffer = "",
            nvim_lsp = "",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[Latex]",
            cmp_tabnine = "",
            copilot = ""
          })
        }
      )
    },
    experimental = {ghost_text = true}
  }
)

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

local tabnine = require('cmp_tabnine.config')

tabnine:setup({})
