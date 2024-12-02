local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

--INFO: Highlight on yank

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--INFO: Remove trailing whitespace on save

autocmd("BufWritePre", {
  pattern = "*",
  group = augroup("TrimWhitespace", { clear = true }),
  callback = function()
    vim.cmd [[%s/\s\+$//e]]
  end,
})

--INFO: Group for LSP-related autocommands

local lsp_group = augroup("LspAutocommands", { clear = true })

--INFO: Automatically format files on save

autocmd("BufWritePre", {
  group = lsp_group,
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})

--INFO: Show lightbulb for code actions

autocmd({ "CursorHold", "CursorHoldI" }, {
  group = lsp_group,
  callback = function()
    require("nvim-lightbulb").update_lightbulb()
  end,
})

