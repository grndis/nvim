-- Function to save cursor and window view
local function save_position()
  return {
    cursor = vim.fn.getpos ".",
    view = vim.fn.winsaveview(),
  }
end

-- Function to restore cursor and window view
local function restore_position(position)
  vim.fn.setpos(".", position.cursor)
  vim.fn.winrestview(position.view)
end

-- Autocmds for file save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function() vim.g.save_position = save_position() end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function() restore_position(vim.g.save_position) end,
})
