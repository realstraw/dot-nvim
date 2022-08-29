require("nvim-tree").setup({
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = { "<CR>", "o" }, action = "edit_no_picker" },
        { key = "i", action = "vsplit" },
      },
    }
  },
  filters = { custom = { "^.git$" } },
})
