return {
	{
		"stevearc/conform.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					css = { "prettier" },
					html = { "prettier" },
					javascript = { "prettier" },
					json = { "prettier" },
					lua = { "stylua" },
					markdown = { "markdownlint", "prettier" },
					python = { "ruff" },
					scss = { "prettier" },
					sh = { "shfmt", "shellcheck" },
				},
				format_on_save = true,
				notify_on_error = true,
				default_format_opts = {
					timeout_ms = 2000, -- Adjust timeout for large files
					quiet = false, -- Show notifications for warnings/errors
					stop_after_first = true, -- Use the first formatter in the list
				},
			})
		end,
	},
}
