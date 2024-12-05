return {
	"toppair/peek.nvim",
	event = { "VeryLazy" },
	build = "deno task --quiet build:fast",
	config = function()
		require("peek").setup({
			theme = "dark", -- Set to 'light' or 'dark'
			app = "webview", -- 'webview', 'browser', string or a table of strings
		})
	end,
}
