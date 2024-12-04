return
{
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")

      ls.setup({
        keep_roots = true,                                     -- Link snippet roots
        link_roots = true,                                     -- Link snippet roots (useful for shared snippets)
        exit_roots = true,                                     -- Allow exiting root snippets at $0
        link_children = true,                                  -- Link children nodes
        update_events = { "TextChanged", "TextChangedI" },     -- Update on text change
        region_check_events = { "CursorMoved", "CursorHold" }, -- When to check region boundaries
        delete_check_events = { "TextChanged" },               -- When to check for snippet deletion
        enable_autosnippets = true,                            -- Enable autosnippets for autotriggered snippets
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "●", "GruvboxBlue" } },
            },
          },
        },
      })

      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  }
}
