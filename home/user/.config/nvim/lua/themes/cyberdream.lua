return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme cyberdream")
      require("cyberdream").setup({
        extensions = {
          lazy = true,
          telescope = true,
          treesitter = true,
          fzflua = true,
          gitsigns = true,
          whichkey = true,
          dashboard = true,
          indentblankline = true,
          leap = true,
          cmp = true,
          treesittercontext = true,
          trouble = true,
          notify = true,
        }
      })
    end,
  }
}
