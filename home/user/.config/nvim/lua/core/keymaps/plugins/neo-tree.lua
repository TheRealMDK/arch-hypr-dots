map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
  vim.keymap.set(mode, lhs, rhs, opts)
end

map(
  "n",
  "<leader>/",
  "<cmd>Neotree toggle current reveal_force_cwd float<CR>",
  { desc = "Toggle Neo-tree and reveal current directory" }
)

map(
  "n",
  "|",
  "<cmd>Neotree reveal<CR>",
  { desc = "Reveal current file in Neo-tree" }
)


map(
  "n",
  "<leader>B",
  "<cmd>Neotree toggle show buffers right<CR>",
  { desc = "Toggle Neo-tree buffer view on the right" }
)

map(
  "n",
  "<leader>S",
  "<cmd>Neotree float git_status<CR>",
  { desc = "Show Neo-tree Git status in float" }
)
