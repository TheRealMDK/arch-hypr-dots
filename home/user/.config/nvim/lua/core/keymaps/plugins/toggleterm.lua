map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
	vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<leader>Tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Toggle Vertical Terminal" })

map("n", "<leader>Th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle Horizontal Terminal" })

map("n", "<leader>Tt", "<cmd>ToggleTerm direction=tab<cr>", { desc = "Toggle Terminal in New Tab" })

map("n", "<leader>Tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle Float Terminal" })

--INFO: Terminal window mappings

-- It can be helpful to add mappings to make moving in and out of a terminal easier once toggled, whilst still keeping it open.

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- Apply terminal-specific keymaps on terminal open

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
