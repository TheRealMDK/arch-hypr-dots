return {
  {
    "stevearc/oil.nvim",
    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {},
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      --[[{
        "echasnovski/mini.icons", opts = {}
      }--]]
    },
    config = function()
      require("oil").setup({
        default_file_explorer = false, -- Avoid overriding Neo-tree
        constrain_cursor = "editable",
        watch_for_changes = true,
        use_default_keymaps = true,

        view_options = {
          show_hidden = true,
          is_hidden_file = function(name, bufnr)
            local m = name:match("^%.")
            return m ~= nil
          end,
          natural_order = "fast",
          case_insensitive = false,
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
        },
      })
    end,
  }
}
