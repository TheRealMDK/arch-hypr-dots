-- INFO: LSP client notifications setup

function lsp_client_notifications(client)
  vim.notify(client.name .. " has attached successfully", vim.log.levels.INFO, { title = "LSP Client" })
end

return {
  lsp_client_notifications = lsp_client_notifications,

}
