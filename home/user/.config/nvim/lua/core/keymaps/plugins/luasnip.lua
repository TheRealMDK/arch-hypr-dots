map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap ~= nil and opts.noremap or true -- Default to noremap if not set
	vim.keymap.set(mode, lhs, rhs, opts)
end

local ls = require("luasnip")

map({ "i" }, "<C-K>", function()
	ls.expand()
end, { silent = true, desc = "Expand snippet" })

map({ "i", "s" }, "<C-L>", function()
	ls.jump(1)
end, { silent = true, desc = "Jump to next snippet" })

map({ "i", "s" }, "<C-J>", function()
	ls.jump(-1)
end, { silent = true, desc = "Jump to prev snippet" })

map({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true, desc = "Next choice in active snippet" })
