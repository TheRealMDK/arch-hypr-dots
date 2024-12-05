return {
	"glepnir/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = {
				enable = true,
			},
			ui = {
				border = "rounded",
			},
		})
	end,
}
