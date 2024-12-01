return{
  {
    "numToStr/Comment.nvim",
    config = function()
      local comments = require("Comment")
      comments.setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  }
}
