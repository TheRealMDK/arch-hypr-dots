return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = 'nvim-treesitter.configs',

    config = function ()

      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
            "awk",
            "bash",
            "comment",
            "css",
            "diff",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "html",
            "htmldjango",
            "http",
            "hyprlang",
            "javascript",
            "json",
            "json5",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            "requirements",
            "scss",
            "toml",
            "typescript",
            "vim",
            "vimdoc"
          },
          auto_install = true,
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end,
  }
}
