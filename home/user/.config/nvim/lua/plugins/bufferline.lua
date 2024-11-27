return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
      require("bufferline").setup({
        options = {
          mode = "tabs",
          separator_style = "slant",
          show_buffer_close_icons = false,
          show_close_icon = false,
          always_show_bufferline = true,
          numbers = "ordinal",
          diagnostics = "nvim_lsp",
          sort_by = "tabs", --'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory'
          indicator = {
                style = "icon", --"underline" | "none"
            },
          hover = {
            enabled = true,
            delay = 200,
          }
        },
      })
    end,
  }
}
