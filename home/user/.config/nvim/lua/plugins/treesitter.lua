return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "c",
        "cpp",
        "comment",
        "css",
        "diff",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "htmldjango",
        "http",
        "hyprlang",
        "json5",
        "luadoc",
        "requirements",
        "scss",
        "toml",
        "vimdoc",
      })
    end,
  },
}
