return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          --position = "right",
          position = "float",
--          popup = {
--            size = {
--              height = "75%",
--              width = "50%",
--            },
--            position = "50%",
--            border = "rounded",
--          },
        },

        filesystem = {
          filtered_items = {
            visible = true, -- Show hidden files by default
          },
        },
      })
    end,
  }
}

