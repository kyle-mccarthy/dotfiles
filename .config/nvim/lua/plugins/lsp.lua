require("mason").setup()
require("mason-lspconfig").setup(
  {
    ensure_installed = {
      "rust_analyzer",
      "eslint",
      "grammarly",
      "jsonls",
      "marksman",
      "tsserver",
      "yamlls",
      "denols"
    }
  }
)

local rt = require("rust-tools")
local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.tsserver.setup {
  capabilities = capabilities,
  flags = { debounce_text_changes = 150 },
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
}

lspconfig.eslint.setup {
  capabilities = capabilities,
  settings = { format = { enable = false } },
  flags = { debounce_text_changes = 250 }
}

-- lspconfig.tailwindcss.setup {filetypes = {"javascriptreact", "typescriptreact"}}

lspconfig.sumneko_lua.setup {
  capabilities = capabilities,

  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      -- format = {enable = false}
    }
  },
}

lspconfig.efm.setup {
  capabilities = capabilities,
  filetypes = { 'lua' },
  settings = {
    init_options = { documentFormatting = true },
    languages = {
      lua = {
        {
          formatCommand = 'lua-format -c ~/.config/lua-format.yaml -i',
          formatStdin = true
        }
      }
    }
  },
}

lspconfig.pyright.setup { capabilities = capabilities }

lspconfig.taplo.setup { capabilities = capabilities }

rt.setup(
  {
    tools = { inlay_hints = { only_current_line = true } },
    server = {
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            allFeatures = true,
            overrideCommand = {
              'cargo',
              'clippy',
              '--message-format=json',
              '--all-targets',
              '--all-features'
            }
          },
          rustfmt = { extraArgs = { "+nightly" } },
          completion = { callable = { snippets = "fill_arguments" } },
          cargo = { buildScripts = { enable = true } }
        }
      }
    }
  }
)

lspconfig.dockerls.setup { capabilities = capabilities }
