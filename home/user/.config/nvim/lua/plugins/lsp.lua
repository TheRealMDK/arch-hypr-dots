local servers = require("core.lsp-servers")

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "SmiteshP/nvim-navic",
      "j-hui/fidget.nvim",
      "smjonas/inc-rename.nvim",
      "glepnir/lspsaga.nvim",
      "kosayoda/nvim-lightbulb",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      local default_config = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          require("core.utils").setup_lsp(client, bufnr)
          require("core.keymaps.plugins.lsp")(bufnr)
        end,
      }

      -- Custom overrides for specific servers
      local server_overrides = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = {
                  "vim",
                }
              },
            },
          },
        },
        harper_ls = {
          settings = {
            ["harper-ls"] = {
              linters = {
                spell_check = false,
                sentence_capitalization = false,
              }
            }
          }
        },
        html = {
          filetypes = { "html", "htmldjango" }, -- Extend filetypes to include htmldjango
        },
      }
      -- Apply setup for all servers
      for _, server in ipairs(servers) do
        local config = vim.tbl_deep_extend("force", default_config, server_overrides[server] or {})
        lspconfig[server].setup(config)
      end
    end,
  }
}
