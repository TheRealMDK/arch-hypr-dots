--INFO: Schedule clipboard configuration to avoid issues during startup

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

--INFO: General UI and usability settings

vim.opt.number = true -- Show line numbers
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.showmode = false -- Hide mode (handled by statusline plugins)
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.undofile = false -- Disable persistent undo
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true -- Smart case search (overrides ignorecase if uppercase is used)
vim.opt.signcolumn = "yes" -- Always show signcolumn
vim.opt.updatetime = 50 -- Reduce update time for responsiveness
vim.opt.timeoutlen = 300 -- Timeout for mapped sequences
vim.opt.splitright = true -- Split vertical windows to the right
vim.opt.splitbelow = true -- Split horizontal windows to the bottom
vim.opt.list = true -- Show invisible characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Define characters for tabs, trailing spaces, etc.
vim.opt.inccommand = "split" -- Preview incremental substitution
vim.opt.cursorline = true -- Highlight the current line
vim.opt.scrolloff = 5 -- Keep 5 lines visible around the cursor

--INFO: Indentation settings

vim.opt.tabstop = 2 -- Tab width
vim.opt.softtabstop = 2 -- Spaces per Tab key press
vim.opt.shiftwidth = 2 -- Spaces per indentation level
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart indentation

--INFO: Disable backups

vim.opt.backup = false

--INFO: Search behavior

vim.opt.hlsearch = true -- Set to "false" to disable highlight search
vim.opt.incsearch = true -- Enable incremental search

--INFO: Append to isfname

vim.opt.isfname:append("@-@")

--INFO: Text wrapping settings

vim.opt.wrap = true -- Set to "false" to disable wrapping by default
vim.opt.linebreak = true -- Prevent breaking words in the middle
vim.opt.breakindent = true -- Indent wrapped lines for readability
vim.opt.showbreak = ">> " -- Add prefix for wrapped lines
vim.opt.textwidth = 80

--INFO: Tree-sitter based folding

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "1"
vim.o.foldlevel = 99
