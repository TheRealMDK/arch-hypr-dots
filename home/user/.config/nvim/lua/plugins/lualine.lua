return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "eldritch", -- "fluoromachine" | "retrowave" | "delta" | "auto" | "eldritch"
				},
			})
		end,
	},
}
