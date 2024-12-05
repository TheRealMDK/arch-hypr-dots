map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
	vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })

map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })
