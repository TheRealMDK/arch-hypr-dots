local cmp_sources = require("core.cmp-sources").sources
local additional_dependencies = require("core.cmp-sources").additional_dependencies

-- Extract source dependencies
local dependencies = {}
for _, source in ipairs(cmp_sources) do
  if source.dependency then
    table.insert(dependencies, source.dependency)
  end
end

-- Add additional dependencies
vim.list_extend(dependencies, additional_dependencies)

-- Debug log for the sources and dependencies
--vim.notify("Configured cmp sources: " .. vim.inspect(cmp_sources))
--vim.notify("Configured cmp dependencies: " .. vim.inspect(additional_dependencies))

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = dependencies,
    config = function()
      -- Setup nvim-cmp for completion
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources(vim.tbl_map(function(s)
          return { name = s.name }
        end, cmp_sources)),
      })

      -- Setup for cmdline completion
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done() -- Ensure autopairs handles the completion insertion
      )
    end,
  }
}
