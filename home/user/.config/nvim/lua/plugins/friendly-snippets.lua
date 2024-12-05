return {
	{
		"rafamadriz/friendly-snippets",
		dependencies = { "L3MON4D3/LuaSnip" },
		config = function()
			-- local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()

			-- Optional: Set up snippet directories if you want to add your custom snippets
			-- luasnip.config.set_config({
			--   history = true,
			--   updateevents = "TextChanged,TextChangedI",
			-- })

			-- Example of loading additional snippet paths (if needed)
			-- luasnip.loaders.from_vscode.lazy_load({ paths = { "~/.config/nvim/my-snippets" } })
		end,
	},
}
