local autocmd = vim.api.nvim_create_autocmd

--INFO: Highlight on yank.

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--INFO: Remove trailing whitespace on save.

autocmd({"BufWritePre"}, {
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- INFO: Attach LSP-specific autocmds

local function lsp_attach_autocmds(client, bufnr)
  local group = vim.api.nvim_create_augroup("lsp-commands", { clear = false })

  -- Auto-format on save if supported
  if client.server_capabilities.documentFormattingProvider then
    autocmd("BufWritePre", {
      group = group,
      buffer = bufnr,
      desc = "Autoformat before save",
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

-- Make lsp_attach_autocmds accessible externally
return {
  lsp_attach_autocmds = lsp_attach_autocmds,
}


