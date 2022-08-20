local null_ls = require('null-ls')

null_ls.setup(
  {
    sources = {
      -- null_ls.builtins.formatting.prettier.with({ prefer_local = true }),
      -- null_ls.builtins.formatting.rustywind,

      -- eslint
      -- null_ls.builtins.diagnostics.eslint_d,
      -- null_ls.builtins.code_actions.eslint_d,
      -- null_ls.builtins.formatting.eslint,
      -- null_ls.builtins.diagnostics.eslint_d,

      -- refactoring
      null_ls.builtins.code_actions.refactoring,

      -- python
      -- null_ls.builtins.formatting.autopep8,
      -- null_ls.builtins.formatting.black,
      -- null_ls.builtins.diagnostics.mypy,

      -- docs
      null_ls.builtins.diagnostics.vale,

      -- protoc
      null_ls.builtins.diagnostics.buf,
      null_ls.builtins.formatting.buf.with(
        {
          extra_args = function(params)
            local scan = require("plenary.scandir")

            local paths = scan.scan_dir(params.root, {search_pattern = "buf.yaml"})
            local config = paths[1]

            if config then
              return {"--config=" .. config, "--path=" .. params.bufname, "--output=" .. params.temp_path}
            end

            return {}
          end,
          args = {"format"}
        }
      )

      -- null_ls.builtins.formatting.
    }
  }
)
