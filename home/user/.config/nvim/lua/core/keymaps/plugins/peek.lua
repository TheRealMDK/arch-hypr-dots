--[[ map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
  vim.keymap.set(mode, lhs, rhs, opts)
end

map(
  "n",
  "<Leader>mo",
  "<cmd>PeekOpen<CR>",
  { desc = "Open Peek" }
)

map(
  "n",
  "<Leader>mc",
  "<cmd>PeekClose<CR>",
  { desc = "Close Peek" }
) ]]


-- Custom map function for keybindings
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Create PeekOpen and PeekClose commands
vim.api.nvim_create_user_command('PeekOpen', function()
  require('peek').open()
end, { desc = "Open Peek Markdown Preview" })

vim.api.nvim_create_user_command('PeekClose', function()
  require('peek').close()
end, { desc = "Close Peek Markdown Preview" })

-- Keymaps for Peek
map("n", "<Leader>mo", "<cmd>PeekOpen<CR>", { desc = "Open Peek Markdown Preview" })
map("n", "<Leader>mc", "<cmd>PeekClose<CR>", { desc = "Close Peek Markdown Preview" })
