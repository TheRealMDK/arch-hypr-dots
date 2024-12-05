map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
	vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "New tab" })

map("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab" })

map("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })

map("n", "<leader>ts", "<cmd>tab split<CR> <cmd>bnext<CR>", { desc = "Split to new tab" })
