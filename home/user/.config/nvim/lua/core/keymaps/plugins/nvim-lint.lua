map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap ~= nil and opts.noremap or true
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Trigger linting manually
map("n", "<Leader>cl", function()
	require("lint").try_lint()
end, { silent = true, desc = "Lint current file" })
