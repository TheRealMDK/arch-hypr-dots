return {
 {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "j-hui/fidget.nvim",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities())

      require("fidget").setup({})
      require("mason").setup({})

      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          
        },

        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
              capabilities = capabilities
            }
          end,

          -- *** Define custom settings fo individual servers here:

          -- Fix Undefined global "vim" in lua-ls
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  --runtime = { version = "Lua 5.1" },
                  diagnostics = {
                    globals = { "vim" },
                  }
                }
              }
            }
          end,
        }
      })

      require("cmp").setup({
        
      })
--      require("").setup({})
--      require("").setup({})
--      require("").setup({})
--      require("").setup({})
--      require("").setup({})
--      require("").setup({})
    end,
  }
}

-- 
