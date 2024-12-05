map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
	vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<Leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", { desc = "Add file (Harpoon)" })

map(
	"n",
	"<Leader>hq",
	"<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
	{ desc = "Quick menu toggle (Harpoon)" }
)

map("n", "<Leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<CR>", { desc = "Next mark (Harpoon)" })

map("n", "<Leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", { desc = "Previous mark (Harpoon)" })

map("n", "<Leader>ht", "<cmd>Telescope harpoon marks<CR>", { desc = "Telescope mark (Harpoon)" })
