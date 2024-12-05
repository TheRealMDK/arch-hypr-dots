map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
	vim.keymap.set(mode, lhs, rhs, opts)
end

local persistence = require("persistence")

map("n", "<Leader>ps", function()
	persistence.save()
end, { desc = "Save session (Persistence)" })

map("n", "<Leader>pS", function()
	persistence.select()
end, { desc = "Select session (Persistence)" })

map("n", "<Leader>pl", function()
	persistence.load()
end, { desc = "Load session (Persistence)" })

map("n", "<Leader>pq", function()
	persistence.stop()
end, { desc = "Quit session (Persistence)" })
