-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.phpcbf.with {
        command = "phpcbf",
        extra_args = {
          "--standard=WordPress", -- or "WordPress" if you've installed it
          "-",
        },
        to_stdin = true,
      },
      null_ls.builtins.diagnostics.phpcs.with {
        command = "phpcs",
        args = {
          "--standard=WordPress",
          "-",
        },
        to_stdin = true,
      },
    }
    return config -- return final config table
  end,
}
