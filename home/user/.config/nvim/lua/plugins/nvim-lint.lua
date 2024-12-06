return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				css = { "stylelint" },
				html = { "djlint" },
				javascript = { "eslint_d" },
				json = { "jsonlint" },
				lua = { "selene" },
				markdown = { "markdownlint" },
				python = { "ruff" },
				scss = { "stylelint" },
				sh = { "shellcheck" },
			}
		end,
	},
}
