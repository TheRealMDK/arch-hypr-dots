map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
	vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<Leader>cf", function()
	require("conform").format({ async = true })
end, { silent = true, desc = "Format current file" })
