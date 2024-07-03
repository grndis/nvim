-- Function to save cursor and window view
local function save_position()
  return {
    cursor = vim.fn.getpos ".",
    view = vim.fn.winsaveview(),
  }
end

-- Function to restore cursor and window view
local function restore_position(position)
  if position then
    vim.fn.setpos(".", position.cursor)
    vim.fn.winrestview(position.view)
  end
end

-- Global variable to store save position
_G.saved_position = nil

-- Save cursor and view position before formatting
local function before_format() _G.saved_position = save_position() end

-- Restore cursor and view position after formatting
local function after_format()
  if _G.saved_position then
    restore_position(_G.saved_position)
    _G.saved_position = nil
  end
end

-- Function to wrap the format command
local function wrapped_formatting(bufnr)
  before_format()
  vim.lsp.buf.format {
    bufnr = bufnr,
    async = true,
    on_done = function() after_format() end,
  }
end

-- Setup autocmds to ensure position preservation
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = before_format,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = after_format,
})

-- Wrap formatting capabilities after LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client.server_capabilities.documentFormattingProvider then
      local format_cmd = function() wrapped_formatting(bufnr) end

      -- Use BufWritePre and BufWritePost to handle manual formatting
      vim.api.nvim_buf_create_user_command(bufnr, "Format", format_cmd, { desc = "Format current buffer with LSP" })

      -- If you want to directly trigger :Format from lsp.buf.format, hook it here
      -- Ensure manual calls do the same thing
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lf", "<cmd>Format<CR>", { noremap = true, silent = true })
    end
  end,
})

-- Command to manually trigger formatting for the current buffer
vim.api.nvim_create_user_command("LspFormat", function()
  local bufnr = vim.api.nvim_get_current_buf()
  wrapped_formatting(bufnr)
end, { desc = "Format current buffer with LSP" })
