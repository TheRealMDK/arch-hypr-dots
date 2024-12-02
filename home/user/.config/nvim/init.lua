vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.have_nerd_font = true

require("lazy-init")
require("core.keymaps-init")
require("core.options")
require("core.autocmds")
require("core.utils")
