return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			--[[
      *** Example configurations ***

      -- Python adapter
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return vim.fn.input("Path to python: ", "python", "file")
          end,
        },
      }

      -- JavaScript (Node.js) adapter
      dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { os.getenv("HOME") .. "/.local/share/nvim/vscode-node-debug2/out/src/nodeDebug.js" },
      }
      dap.configurations.javascript = {
        {
          type = "node2",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
        },
      }
--]]

			-- Keybindings for debugging
			local keymap = vim.keymap.set
			keymap("n", "<F5>", dap.continue, { desc = "Start/Continue Debugging" })
			keymap("n", "<F10>", dap.step_over, { desc = "Step Over" })
			keymap("n", "<F11>", dap.step_into, { desc = "Step Into" })
			keymap("n", "<F12>", dap.step_out, { desc = "Step Out" })
			keymap("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			keymap("n", "<Leader>DB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Set Conditional Breakpoint" })
		end,
	},
}
