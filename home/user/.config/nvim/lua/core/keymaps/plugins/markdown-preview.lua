map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
  vim.keymap.set(mode, lhs, rhs, opts)
end

map(
  "n",
  "<Leader>mp",
  "<cmd>MarkdownPreviewToggle<CR>",
  { desc = "Start or toggle Markdown Preview" }
)

map(
  "n",
  "<Leader>ms",
  "<cmd>MarkdownPreviewStop<CR>",
  { desc = "Stop Markdown Preview" }
)

map(
  "n",
  "<Leader>mr",
  "<cmd>MarkdownPreview<CR>",
  { desc = "Refresh Markdown Preview" }
)
