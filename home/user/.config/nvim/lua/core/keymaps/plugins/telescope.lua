map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
	vim.keymap.set(mode, lhs, rhs, opts)
end

local builtin = require("telescope.builtin")

map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })

map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })

map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })

map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
