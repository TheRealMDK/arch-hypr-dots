return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          position = "right",
          --position = "float",
        },

        filesystem = {
          filtered_items = {
            visible = true, -- Show hidden files by default
          },
        },
      })

      vim.keymap.set(
        'n',
        '<leader>/',
        '<cmd>Neotree toggle current reveal_force_cwd right<CR>',
        { desc = 'Toggle Neo-tree and reveal current directory' }
      )

      vim.keymap.set(
        'n',
        '|',
        '<cmd>Neotree reveal<CR>',
        { desc = 'Reveal current file in Neo-tree' }
      )

      vim.keymap.set(
        'n',
        '<leader>gd',
        '<cmd>lua require("neo-tree").toggle("float", { reveal_file = vim.fn.expand("<cfile>"), reveal_force_cwd = true })<CR>',
        { desc = 'Open Neo-tree float and reveal file under cursor' }
      )

      --[[
      vim.keymap.set(
        'n',
        '<leader>gd',
        '<cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<CR>',
        { desc = 'Open Neo-tree float and reveal file under cursor' }
      )
      --]]

      vim.keymap.set(
        'n',
        '<leader>b',
        '<cmd>Neotree toggle show buffers right<CR>',
        { desc = 'Toggle Neo-tree buffer view on the right' }
      )

      vim.keymap.set(
        'n',
        '<leader>s',
        '<cmd>Neotree float git_status<CR>',
        { desc = 'Show Neo-tree Git status in float' }
      )

    end,
  }
}

