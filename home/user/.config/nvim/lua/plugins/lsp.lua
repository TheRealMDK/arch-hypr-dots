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
      "nvim-neotest/nvim-nio",
      "folke/lazydev.nvim",
    },
    config = function()

      local servers = {
        "bashls", --Bash
        "ast_grep", --Many
        "css_variables", --CSS
        "cssls", --CSS
        "cssmodules_ls", --CSS
        "tailwindcss", --CSS
        "emmet_language_server", --Emmet
        "emmet_ls", --Emmet
        "html", --HTML
        "hyprls", --Hyprland
        "biome", --Javascript
        "eslint", --Javascript
        "harper_ls", --Javascript
        "quick_lint_js", --Javascript
        "ts_ls", --Javascript
        "jsonls", --Json
        "lua_ls", --Lua
        "markdown_oxide", --Markdown
        "marksman", --Markdown
        "zk", --Markdown
        "pylyzer", --Python
        "pyright", --Python
        "ruff", --Python
        "somesass_ls", --SCSS
        "stylelint_lsp", --Stylint
      }

      local lspconfig = require("lspconfig")
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      local default_config = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          vim.notify(client.name .. " LSP attached to buffer " .. bufnr)
        end
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
      require("mason").setup({})
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = servers,
      })
      require("fidget").setup({})
      require("cmp").setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },

        mapping = require("cmp").mapping.preset.insert({
          ['<C-b>'] = require("cmp").mapping.scroll_docs(-4),
          ['<C-f>'] = require("cmp").mapping.scroll_docs(4),
          ['<C-Space>'] = require("cmp").mapping.complete(),
          ['<C-e>'] = require("cmp").mapping.abort(),
          ['<CR>'] = require("cmp").mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),

        sources = require("cmp").config.sources({
          { name = 'nvim_lsp' },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
        })
      })

      require("cmp").setup.cmdline({ '/', '?' }, {
        mapping = require("cmp").mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      require("cmp").setup.cmdline(':', {
        mapping = require("cmp").mapping.preset.cmdline(),
        sources = require("cmp").config.sources({
          { name = 'path' }
        }, {
            { name = 'cmdline' }
          }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

    end,
  }
}

