map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- INFO: Window focus

map(
  "n",
  "<C-h>",
  "<C-w><C-h>",
  { desc = "Move focus to the left window" }
)

map(
  "n",
  "<C-l>",
  "<C-w><C-l>",
  { desc = "Move focus to the right window" }
)

map(
  "n",
  "<C-j>",
  "<C-w><C-j>",
  { desc = "Move focus to the lower window" }
)

map(
  "n",
  "<C-k>",
  "<C-w><C-k>",
  { desc = "Move focus to the upper window" }
)

-- INFO: Window split

map(
  "n",
  "<leader>wh",
  "<cmd>split<CR>",
  { desc = "Horizontal split" }
)

map(
  "n",
  "<leader>wv",
  "<cmd>vsplit<CR>",
  { desc = "Vertical split" }
)

-- INFO: Window resize

map(
  "n",
  "<C-Up>",
  "<cmd>resize +2<CR>",
  { desc = "Increase height" }
)

map(
  "n",
  "<C-Down>",
  "<cmd>resize -2<CR>",
  { desc = "Decrease height" }
)

map(
  "n",
  "<C-Left>",
  "<cmd>vertical resize -2<CR>",
  { desc = "Decrease width" }
)

map(
  "n",
  "<C-Right>",
  "<cmd>vertical resize +2<CR>",
  { desc = "Increase width" }
)
