map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
  vim.keymap.set(mode, lhs, rhs, opts)
end


map(
  "n",
  "<leader>Tv",
  "<cmd>ToggleTerm direction=vertical<cr>",
  { desc = "Toggle Vertical Terminal" }
)

map(
  "n",
  "<leader>Th",
  "<cmd>ToggleTerm direction=horizontal<cr>",
  { desc = "Toggle Horizontal Terminal" }
)

map(
  "n",
  "<leader>Tt",
  "<cmd>ToggleTerm direction=tab<cr>",
  { desc = "Toggle Terminal in New Tab" }
)
