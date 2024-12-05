return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<C-`>]],
				direction = "float", --"vertical" | "horizontal" | "tab" | "float"
				close_on_exit = true,
				size = 50, -- Adjust size as needed
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2, -- Darkness of terminal background (higher = darker)
				shell = vim.o.shell, -- Ensure correct shell is used (bash, zsh, etc.)
				persist_size = true, -- Keeps terminal size after closing
				highlights = {
					Normal = {
						guibg = "#1c1c1c", -- Background color for terminal
					},
					FloatBorder = {
						guifg = "#ff0000", -- Border color for floating terminal
					},
				},
				open_on_tab = false, -- Don't open in the current tab, always open a new one
				insert_mappings = true, -- Enable insert mappings
			})
		end,
	},
}
