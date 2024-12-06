local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.autopairs"),
	require("plugins.bufferline"),
	require("plugins.cmp"),
	require("plugins.comment"),
	require("plugins.conform"),
	require("plugins.dap-ui"),
	require("plugins.dashboard"),
	require("plugins.emmet"),
	require("plugins.fidget"),
	require("plugins.friendly-snippets"),
	require("plugins.fugitive"),
	require("plugins.git-signs"),
	require("plugins.harpoon"),
	require("plugins.inc-rename"),
	require("plugins.indent-blanklines"),
	require("plugins.leap"),
	require("plugins.lightbulb"),
	require("plugins.lsp"),
	require("plugins.lspsaga"),
	require("plugins.lualine"),
	require("plugins.luarocks"),
	require("plugins.mason"),
	require("plugins.navic"),
	require("plugins.neo-tree"),
	require("plugins.notify"),
	require("plugins.nvim-dap"),
	require("plugins.nvim-lint"),
	require("plugins.oil"),
	require("plugins.peek"),
	require("plugins.persistence"),
	require("plugins.project"),
	require("plugins.rainbow-delimiters"),
	require("plugins.refactoring"),
	require("plugins.symlink"),
	require("plugins.telescope"),
	require("plugins.template-string"),
	require("plugins.todo-comments"),
	require("plugins.toggleterm"),
	require("plugins.treesitter"),
	require("plugins.treesitter-context"),
	require("plugins.treesitter-textobjects"),
	require("plugins.trouble"),
	require("plugins.ts-autotag"),
	require("plugins.ts-comment-string"),
	require("plugins.which-key"),
	require("plugins.zen-mode"),

	--require("themes.cyberdream"),
	require("themes.eldritch"),
	-- require("themes.fluoromachine"),
})
