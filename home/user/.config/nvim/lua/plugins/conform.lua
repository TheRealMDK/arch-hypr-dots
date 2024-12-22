return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Add formatters for filetypes based on the above configuration
      bash = { "shfmt" },
      css = { "prettier" },
      html = { "prettier", "djlint" },
      javascript = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "markdownlint", "prettier" },
      python = { "ruff" },
      sass = { "prettier" },
      scss = { "prettier" },
      shell = { "shfmt" },
      tailwindcss = { "prettier" },
    },
  },
}
