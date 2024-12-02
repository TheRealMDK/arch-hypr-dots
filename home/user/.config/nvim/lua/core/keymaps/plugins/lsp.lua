return function(bufnr)
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Hover
  map("n", "K", vim.lsp.buf.hover, opts)

  -- Go to definition
  map("n", "gd", vim.lsp.buf.definition, opts)

  -- Go to declaration
  map("n", "gD", vim.lsp.buf.declaration, opts)

  -- Go to implementation
  map("n", "gi", vim.lsp.buf.implementation, opts)

  -- Find references
  map("n", "gr", vim.lsp.buf.references, opts)

  -- Rename symbol
  map("n", "<leader>rn", "<cmd>lua require('inc_rename').rename()<CR>", opts)

  -- Code action
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end
