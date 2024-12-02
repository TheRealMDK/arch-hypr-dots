map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
  vim.keymap.set(mode, lhs, rhs, opts)
end

map(
  "n",
  "<Leader>xb",
  "<cmd>Trouble diagnostics toggle focus=false win = { type = 'split', position='right'} filter.buf=0<CR>",
  { desc = "Buffer Diagnostics (Trouble)" }
)

map(
  "n",
  "<Leader>xx",
  "<cmd>Trouble diagnostics toggle focus=false win = { type = 'split', position='right'}<CR>",
  { desc = "Diagnostics (Trouble)" }
)

map(
  "n",
  "<Leader>xs",
  "<cmd>Trouble symbols toggle focus=false win = { type = 'split', position='right'}<CR>",
  { desc = "Symbols (Trouble)" }
)

map(
  "n",
  "<Leader>xl",
  "<cmd>Trouble lsp toggle focus=false win = { type = 'split', position='right'}<CR>",
  { desc = "LSP Definitions / references / ... (Trouble)" }
)

map(
  "n",
  "<Leader>xL",
  "<cmd>Trouble loclist toggle focus=false win = { type = 'split', position='right'}<CR>",
  { desc = "Location List (Trouble)" }
)

map(
  "n",
  "<Leader>xq",
  "<cmd>Trouble qflist toggle focus=false win = { type = 'split', position='right'}<CR>",
  { desc = "Quickfix List (Trouble)" }
)
