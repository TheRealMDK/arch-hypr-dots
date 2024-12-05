return {
	{
		"theprimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("harpoon").setup({
				save_on_toggle = false,
			})
			require("telescope").load_extension("harpoon")
		end,
	},
}
