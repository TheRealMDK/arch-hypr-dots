local M = {}

-- Setup `nvim-navic` breadcrumbs
M.setup_navic = function(client, bufnr)
	local navic = require("nvim-navic")
	if client.server_capabilities.documentSymbolProvider then --and not navic.is_attached(bufnr) then
		navic.attach(client, bufnr)
	end
end

-- Setup lightbulb for LSP code actions
M.setup_lightbulb = function()
	require("nvim-lightbulb").setup({
		autocmd = { enabled = true },
	})
end

-- LSP-specific setup
M.setup_lsp = function(client, bufnr)
	M.setup_navic(client, bufnr)
	M.setup_lightbulb()
end

return M
