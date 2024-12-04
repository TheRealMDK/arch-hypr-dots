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

--[[ local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local should_trigger_completion = function()
  return vim.bo.buftype ~= "prompt" and has_words_before()
end ]]

-- Debug log for the sources and dependencies
--vim.notify("Configured cmp sources: " .. vim.inspect(cmp_sources))
--vim.notify("Configured cmp dependencies: " .. vim.inspect(additional_dependencies))

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = dependencies,
    config = function()
      -- Setup nvim-cmp for completion
      local lspkind = require("lspkind")
      local cmp = require("cmp")
      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",     -- show only symbol annotations
            maxwidth = {
              menu = 50,              -- leading text (labelDetails)
              abbr = 50,              -- actual suggestion item
            },
            ellipsis_char = "...",    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            before = function(entry, vim_item)
              return vim_item
            end
          })
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          }),

          ["<C-Space>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },

          --[[ ["<C-Tab>"] = function(fallback)
              if not cmp.select_next_item() then
              if should_trigger_completion then
              cmp.complete()
              else
              fallback()
              end
              end
              end,

              ["<S-Tab>"] = function(fallback)
              if not cmp.select_prev_item() then
              if should_trigger_completion then
              cmp.complete()
              else
              fallback()
              end
              end
              end, ]]
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
        mapping = cmp.mapping.preset.cmdline({
          ["<CR>"] = cmp.mapping({
            c = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
          }),
        }),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        }),
        matching = { disallow_symbol_nonprefix_matching = false } -- Allows partial symbol matching in command-line completion
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done() -- Ensure autopairs handles the completion insertion
      )
    end,
  }
}
