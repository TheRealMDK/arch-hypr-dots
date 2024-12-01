return{
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        show_hidden = true,
        silent_chdir = false,
      })

      require("telescope").load_extension("projects")

      --require("telescope").extensions.projects.projects{}

    end,
  }
}
