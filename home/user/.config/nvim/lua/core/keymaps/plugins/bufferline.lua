map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
  vim.keymap.set(mode, lhs, rhs, opts)
end

map(
  "n",
  "<Tab>",
  "<cmd>BufferLineCycleNext<CR>",
  { desc = "Go to next tab" }
)

map(
  "n",
  "<S-Tab>",
  "<cmd>BufferLineCyclePrev<CR>",
  { desc = "Go to previous tab" }
)
