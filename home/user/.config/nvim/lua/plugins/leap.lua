return{
  {
    "ggandor/leap.nvim",
    dependencies = {"tpope/vim-repeat"},
    config = function()

      local leap = require("leap")
      local leap_user = require("leap.user")

      leap.add_default_mappings()
      leap.opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
      leap_user.set_repeat_keys("<enter>", "<backspace>")
      -- leap.opts.safe_labels = { "a", "s", "d", "f", "g", "h", "j", "k", "l" }
    end,
  }
}
