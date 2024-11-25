vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = '' }) -- Next buffer
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = '' }) -- Previous buffer
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = '' }) -- Close current buffer

vim.keymap.set("n", "<leader>1", "<cmd>buffer 1<CR>", { desc = 'Switch to buffer 1' })
vim.keymap.set("n", "<leader>2", "<cmd>buffer 2<CR>", { desc = 'Switch to buffer 2' })
vim.keymap.set("n", "<leader>3", "<cmd>buffer 3<CR>", { desc = 'Switch to buffer 3' })
vim.keymap.set("n", "<leader>4", "<cmd>buffer 4<CR>", { desc = 'Switch to buffer 4' })
vim.keymap.set("n", "<leader>5", "<cmd>buffer 5<CR>", { desc = 'Switch to buffer 5' })
vim.keymap.set("n", "<leader>6", "<cmd>buffer 6<CR>", { desc = 'Switch to buffer 6' })
vim.keymap.set("n", "<leader>7", "<cmd>buffer 7<CR>", { desc = 'Switch to buffer 7' })
vim.keymap.set("n", "<leader>8", "<cmd>buffer 8<CR>", { desc = 'Switch to buffer 8' })
vim.keymap.set("n", "<leader>9", "<cmd>buffer 9<CR>", { desc = 'Switch to buffer 9' })

vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>", { desc = 'Horizontal split' })
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = 'Vertical split' })

vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = 'Increase height' })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = 'Decrease height' })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = 'Decrease width' })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = 'Increase width' })

vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = 'New tab' })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = 'Next tab' })
vim.keymap.set("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = 'Previous tab' })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = 'Close tab' })

