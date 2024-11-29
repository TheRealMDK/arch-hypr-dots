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
    },
    config = function()
      -- Setup LSP servers
      local lspconfig = require("lspconfig")
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      local default_config = {
        capabilities = capabilities,
--        on_attach = function(client, bufnr)
--          vim.notify(client.name .. " LSP attached to buffer " .. bufnr)
--        end
      }

      -- Custom overrides for specific servers
      local server_overrides = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
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
