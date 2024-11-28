vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.breakindent = true
vim.opt.undofile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.isfname:append("@-@")
vim.opt.timeoutlen = 300

