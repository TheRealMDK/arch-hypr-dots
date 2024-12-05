local M = {}

M.servers = {
	"ast_grep",
	"bashls",
	"cssls",
	"cssmodules_ls",
	"emmet_language_server",
	"eslint",
	"html",
	"hyprls",
	"jsonls",
	"lua_ls",
	"marksman",
	"pyright",
	"ruff",
	"somesass_ls",
	"stylelint_lsp",
	"tailwindcss",
	"ts_ls",
	"zk",
}

M.formatters_and_linters = {
	"djlint",
	"markdownlint",
	"prettier",
	"shellcheck",
	"shfmt",
	"stylua",
}

M.dap = {
	"bash",
	"firefox",
	"js",
	"node2",
	"python",
}

return M
