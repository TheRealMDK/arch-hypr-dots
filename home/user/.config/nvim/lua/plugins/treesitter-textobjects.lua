return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {"nvim-treesitter/nvim-treesitter",},
    config = function()
      local textobjects = require("nvim-treesitter.configs")
      textobjects.setup({})
    end,
  }
}
