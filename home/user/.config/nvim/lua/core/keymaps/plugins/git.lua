map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
	vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<Leader>Gs", "<cmd>Git<CR>", { desc = "Git Status" })

map("n", "<Leader>Gl", "<cmd>Git log<CR>", { desc = "Git Log" })

map("n", "<Leader>Gb", "<cmd>Git blame<CR>", { desc = "Git Blame" })

map("n", "<Leader>Gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git Diff" })
