return {
  require("bigfile").setup {
    filesize = 1, -- Set a lower threshold, e.g., 1 MiB
    pattern = function(bufnr, filesize_mib)
      -- Get the filename
      local filename = vim.api.nvim_buf_get_name(bufnr)

      -- Check if the filename indicates a minified or compressed file
      local is_minified = filename:match "%.min%.[^.]+$" ~= nil
        or filename:match "%.[^.]+%.min$" ~= nil
        or filename:match "%-min%.[^.]+$" ~= nil
        or filename:match "%.[^.]+%-min$" ~= nil
        or filename:match "%.bundle%.[^.]+$" ~= nil
        or filename:match "%.[^.]+%.bundle$" ~= nil
        or filename:match "%.pack%.[^.]+$" ~= nil
        or filename:match "%.[^.]+%.pack$" ~= nil

      -- Check common minified file extensions
      local minified_extensions = { "js", "css", "html", "json", "xml" }
      local ext = filename:match "%.([^.]+)$"
      local is_common_minified = ext and vim.tbl_contains(minified_extensions, ext:lower()) and filesize_mib >= 0.1

      -- Check if the file is larger than the threshold (e.g., 100 KiB)
      local is_large = filesize_mib >= 0.05

      -- Return true if it's a minified/compressed file or a large file of common minified types
      return is_minified or (is_common_minified and is_large)
    end,
    features = {
      "indent_blankline",
      "illuminate",
      "lsp",
      "treesitter",
      "syntax",
      "matchparen",
      "vimopts",
      "filetype",
    },
  },
}
