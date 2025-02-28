return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      -- ["*"] = { "" },
      -- ["_"] = { "" },
      bash = { "shellcheck" },
      c = { "cpplint" },
      cpp = { "cpplint" },
      css = { "stylelint" },
      html = { "djlint" },
      javascript = { "eslint_d" },
      json = { "jsonlint" },
      lua = { "selene" },
      markdown = { "markdownlint" },
      python = { "ruff" },
      sass = { "stylelint" },
      scss = { "stylelint" },
      shell = { "shellcheck" },
      tailwindcss = { "stylelint" },
    },
  },
}
