map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
	vim.keymap.set(mode, lhs, rhs, opts)
end

local todo = require("todo-comments")

map("n", "<Leader>zn", function()
	todo.jump_next()
end, { desc = "Next todo-comment" })

map("n", "<Leader>zp", function()
	todo.jump_prev()
end, { desc = "Previous todo-comment" })

map("n", "<Leader>zt", "<cmd>TodoTelescope<CR>", { desc = "Search TODO comments with Telescope" })

map("n", "<Leader>zT", "<cmd>Trouble todo<CR>", { desc = "List all project todos in trouble" })

map("n", "<Leader>zf", "<cmd>TodoFzfLua<CR>", { desc = "Find all todos with fzf" })

map("n", "<Leader>zl", "<cmd>TodoLocList<CR>", { desc = "Show TODO comments in location list" })

map("n", "<Leader>zq", "<cmd>TodoQuickFix<CR>", { desc = "Show TODO comments in quickfix list" })
