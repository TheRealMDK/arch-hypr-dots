return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local toggleterm = require("toggleterm")
      toggleterm.setup({
        open_mapping = [[<C-`>]],
        direction = "float", --"vertical" | "horizontal" | "tab" | "float"
        close_on_exit = true,
      })
    end,
  }
}
