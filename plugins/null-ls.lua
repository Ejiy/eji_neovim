return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"
    local helpers = require "null-ls.helpers"

    local stylua_ignore_args = { "--config-path", vim.fn.expand("../stylua.toml") }

    local custom_stylua = helpers.make_builtin({
      method = null_ls.methods.FORMATTING,
      filetypes = { "lua" },
      generator_opts = {
        command = "stylua",
        args = function(params)
          return vim.tbl_flatten({ stylua_ignore_args, { params.fname } })
        end,
        to_stdin = true,
      },
      factory = helpers.formatter_factory,
    })
    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      custom_stylua,
      null_ls.builtins.formatting.prettier,
    }
    return config -- return final config table
  end,
}
