vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.have_nerd_font = true

require("core.options")
require("core.keymaps")
require("core.utils")
require("core.autocmds")

require("plugins.init")
