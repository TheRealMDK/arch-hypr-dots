vim.keymap.set(
  "n",
  "<Esc>",
  "<cmd>nohlsearch<CR>"
)

-- *** WINDOW MANAGEMENT ***--

-- Window focus

vim.keymap.set(
  "n",
  "<C-h>",
  "<C-w><C-h>",
  { desc = "Move focus to the left window" }
)

vim.keymap.set(
  "n",
  "<C-l>",
  "<C-w><C-l>",
  { desc = "Move focus to the right window" }
)

vim.keymap.set(
  "n",
  "<C-j>",
  "<C-w><C-j>",
  { desc = "Move focus to the lower window" }
)

vim.keymap.set(
  "n",
  "<C-k>",
  "<C-w><C-k>",
  { desc = "Move focus to the upper window" }
)

-- Window split

vim.keymap.set(
  "n",
  "<leader>sh",
  "<cmd>split<CR>",
  { desc = "Horizontal split" }
)

vim.keymap.set(
  "n",
  "<leader>sv",
  "<cmd>vsplit<CR>",
  { desc = "Vertical split" }
)

-- Window resize

vim.keymap.set(
  "n",
  "<C-Up>",
  "<cmd>resize +2<CR>",
  { desc = "Increase height" }
)

vim.keymap.set(
  "n",
  "<C-Down>",
  "<cmd>resize -2<CR>",
  { desc = "Decrease height" }
)

vim.keymap.set(
  "n",
  "<C-Left>",
  "<cmd>vertical resize -2<CR>",
  { desc = "Decrease width" }
)

vim.keymap.set(
  "n",
  "<C-Right>",
  "<cmd>vertical resize +2<CR>",
  { desc = "Increase width" }
)

-- *** BUFFER MANAGEMENT ***--

vim.keymap.set(
  "n",
  "<leader>bn",
  "<cmd>bnext<CR>",
  { desc = "Next buffer" }
)

vim.keymap.set(
  "n",
  "<leader>bp",
  "<cmd>bprevious<CR>",
  { desc = "Previous buffer" }
)

vim.keymap.set(
  "n",
  "<leader>bd",
  "<cmd>bdelete<CR>",
  { desc = "Close buffer" }
)

-- *** TAB MANAGEMENT ***--

vim.keymap.set(
  "n",
  "<leader>tt",
  "<cmd>tabnew<CR>",
  { desc = "New tab" }
)

vim.keymap.set(
  "n",
  "<leader>tn",
  "<cmd>tabnext<CR>",
  { desc = "Next tab" }
)

vim.keymap.set(
  "n",
  "<leader>tp",
  "<cmd>tabprevious<CR>",
  { desc = "Previous tab" }
)

vim.keymap.set(
  "n",
  "<leader>tc",
  "<cmd>tabclose<CR>",
  { desc = "Close tab" }
)

vim.keymap.set(
  "n",
  "<leader>ts",
  "<cmd>tab split<CR> <cmd>bnext<CR>",
  { desc = "Split to new tab" }
)

-- *** NEO-TREE ***--

vim.keymap.set(
  "n",
  "<leader>/",
  "<cmd>Neotree toggle current reveal_force_cwd float<CR>",
  { desc = "Toggle Neo-tree and reveal current directory" }
)

vim.keymap.set(
  "n",
  "|",
  "<cmd>Neotree reveal<CR>",
  { desc = "Reveal current file in Neo-tree" }
)


vim.keymap.set(
  "n",
  "<leader>B",
  "<cmd>Neotree toggle show buffers right<CR>",
  { desc = "Toggle Neo-tree buffer view on the right" }
)

vim.keymap.set(
  "n",
  "<leader>S",
  "<cmd>Neotree float git_status<CR>",
  { desc = "Show Neo-tree Git status in float" }
)

-- *** OIL ***--

vim.keymap.set(
  "n",
  "<leader>o",
  "<CMD>Oil --float<CR>",
  { desc = "Open Oil in float mode" }
)

-- *** BUFFERLINE ***--

vim.keymap.set(
  "n",
  "<Tab>",
  "<cmd>BufferLineCycleNext<CR>",
  { desc = "Go to next tab" }
)

vim.keymap.set(
  "n",
  "<S-Tab>",
  "<cmd>BufferLineCyclePrev<CR>",
  { desc = "Go to previous tab" }
)

-- *** TELESCOPE ***--

local builtin = require("telescope.builtin")

vim.keymap.set(
  "n",
  "<leader>ff",
  builtin.find_files,
  { desc = "Telescope find files" }
)

vim.keymap.set("n",
  "<leader>fg",
  builtin.live_grep,
  { desc = "Telescope live grep" }
)

vim.keymap.set("n",
  "<leader>fb",
  builtin.buffers,
  { desc = "Telescope buffers" }
)

vim.keymap.set("n",
  "<leader>fh",
  builtin.help_tags,
  { desc = "Telescope help tags" }
)

-- *** TOGGLETERM ***--

vim.keymap.set(
  "n",
  "<leader>Tv",
  "<cmd>ToggleTerm direction=vertical<cr>",
  { desc = "Toggle Vertical Terminal" }
)

vim.keymap.set(
  "n",
  "<leader>Th",
  "<cmd>ToggleTerm direction=horizontal<cr>",
  { desc = "Toggle Horizontal Terminal" }
)

vim.keymap.set(
  "n",
  "<leader>Tt",
  "<cmd>ToggleTerm direction=tab<cr>",
  { desc = "Toggle Terminal in New Tab" }
)

-- *** GIT ***--

vim.keymap.set(
  "n",
  "<Leader>gs",
  "<cmd>Git<CR>",
  { desc = "Git Status" }
)

vim.keymap.set(
  "n",
  "<Leader>gl",
  "<cmd>Git log<CR>",
  { desc = "Git Log" }
)

vim.keymap.set(
  "n",
  "<Leader>gb",
  "<cmd>Git blame<CR>",
  { desc = "Git Blame" }
)

vim.keymap.set(
  "n",
  "<Leader>gd",
  "<cmd>Gvdiffsplit<CR>",
  { desc = "Git Diff" }
)
-- *** TROUBLE ***--

vim.keymap.set(
  "n",
  "<Leader>xb",
  "<cmd>Trouble diagnostics toggle focus=false win = { type = 'split', position='right'} filter.buf=0<CR>",
  { desc = "Buffer Diagnostics (Trouble)" }
)

vim.keymap.set(
  "n",
  "<Leader>xx",
  "<cmd>Trouble diagnostics toggle focus=false win = { type = 'split', position='right'}<CR>",
  { desc = "Diagnostics (Trouble)" }
)

vim.keymap.set(
  "n",
  "<Leader>xs",
  "<cmd>Trouble symbols toggle focus=false win = { type = 'split', position='right'}<CR>",
  { desc = "Symbols (Trouble)" }
)

vim.keymap.set(
  "n",
  "<Leader>xl",
  "<cmd>Trouble lsp toggle focus=false win = { type = 'split', position='right'}<CR>",
  { desc = "LSP Definitions / references / ... (Trouble)" }
)

vim.keymap.set(
  "n",
  "<Leader>xL",
  "<cmd>Trouble loclist toggle focus=false win = { type = 'split', position='right'}<CR>",
  { desc = "Location List (Trouble)" }
)

vim.keymap.set(
  "n",
  "<Leader>xq",
  "<cmd>Trouble qflist toggle focus=false win = { type = 'split', position='right'}<CR>",
  { desc = "Quickfix List (Trouble)" }
)

-- *** HARPOON ***--

vim.keymap.set(
  "n",
  "<Leader>ha",
  "<cmd>lua require('harpoon.mark').add_file()<CR>",
  { desc = "Add file (Harpoon)" }
)

vim.keymap.set(
  "n",
  "<Leader>hq",
  "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
  { desc = "Quick menu toggle (Harpoon)" }
)

vim.keymap.set(
  "n",
  "<Leader>hn",
  "<cmd>lua require('harpoon.ui').nav_next()<CR>",
  { desc = "Next mark (Harpoon)" }
)

vim.keymap.set(
  "n",
  "<Leader>hp",
  "<cmd>lua require('harpoon.ui').nav_prev()<CR>",
  { desc = "Previous mark (Harpoon)" }
)

vim.keymap.set(
  "n",
  "<Leader>ht",
  "<cmd>Telescope harpoon marks<CR>",
  { desc = "Telescope mark (Harpoon)" }
)

-- ***  ***--
-- ***  ***--
-- ***  ***--

-- *** KEYMAP TEMPLATE ***--

--vim.keymap.set(
--  "n",
--  "<Leader>",
--  "<cmd><CR>",
--  { desc = "" }
--)
