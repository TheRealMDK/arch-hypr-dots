return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
      require("bufferline").setup({
        options = {
          mode = "tabs", -- "buffers" | "tabs"
          separator_style = "slant", -- "slant" | "slope" | "thick" | "thin"
          show_buffer_close_icons = false,
          show_close_icon = false,
          always_show_bufferline = true,
          numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both"
          diagnostics = "nvim_lsp",
          sort_by = "tabs", --"insert_after_current" |"insert_at_end" | "id" | "extension" | "relative_directory" | "directory" | "tabs"
          indicator = {
            --icon = "▎", -- this should be omitted if indicator style is not "icon"
            style = "icon", --"icon" | "underline" | "none"
          },
        },
      })
    end,
  }
}
