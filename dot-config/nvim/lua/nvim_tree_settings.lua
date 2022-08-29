require("nvim-tree").setup({
  view = {
    adaptive_size = true,
  },
  filters = { custom = { "^.git$" } },
})
