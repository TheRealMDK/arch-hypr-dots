local servers = require("core.lsp-servers")

return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      require("mason").setup({})
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = servers,
      })
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "bash",
          "firefox",
          "js",
          "node2",
          "python",
        },
        automatic_installation = true,
      })
    end,
  }
}
