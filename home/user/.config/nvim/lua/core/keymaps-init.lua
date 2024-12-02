local keymap_modules = {

  "core.keymaps.buffer-management",
  "core.keymaps.general",
  "core.keymaps.tab-management",
  "core.keymaps.windows-management",

  "core.keymaps.plugins.bufferline",
  "core.keymaps.plugins.git",
  "core.keymaps.plugins.harpoon",
  "core.keymaps.plugins.markdown-preview",
  "core.keymaps.plugins.neo-tree",
  "core.keymaps.plugins.oil",
  "core.keymaps.plugins.persistence",
  "core.keymaps.plugins.project",
  "core.keymaps.plugins.telescope",
  "core.keymaps.plugins.todo-comments",
  "core.keymaps.plugins.toggleterm",
  "core.keymaps.plugins.trouble",
  "core.keymaps.plugins.zen-mode",
}

for _, module in ipairs(keymap_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify("Error loading " .. module .. "\n\n" .. err, vim.log.levels.ERROR)
  end
end

-- NOTE: KEYMAP TEMPLATE

--[[ map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
  vim.keymap.set(mode, lhs, rhs, opts)
end ]]

--[[ map(
 "n",
 "<Leader>",
 "<cmd><CR>",
 { desc = "" }
) ]]
