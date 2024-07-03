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

-- Save cursor and view position before formatting
local function before_format() vim.g.save_position = save_position() end

-- Restore cursor and view position after formatting
local function after_format() restore_position(vim.g.save_position) end

-- Autocmds for file save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = before_format,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = after_format,
})

-- Function to wrap the format command
local function wrapped_format()
  before_format()
  vim.lsp.buf.format {
    async = false,
    on_attach = function() after_format() end,
  }
end

-- Wrap the LSP formatting function on LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_buf_set_keymap(
        args.buf,
        "n",
        "<leader>lf",
        ":lua wrapped_format()<CR>",
        { noremap = true, silent = true }
      )
    end
  end,
})
