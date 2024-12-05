local servers = require("core.lsp-servers").servers
local formatters_and_linters = require("core.lsp-servers").formatters_and_linters
local dap = require("core.lsp-servers").dap

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			require("mason").setup({
				automatic_installation = true,
				ensure_installed = formatters_and_linters,
			})
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = servers,
			})
			require("mason-nvim-dap").setup({
				automatic_installation = true,
				ensure_installed = dap,
			})
		end,
	},
}
