local action_layout = require("telescope.actions.layout")

require('telescope').setup({
  defaults = {
    mappings = {
      n  = {
        ["!"] = action_layout.toggle_preview,
      },
    },
  },
  pickers = {
    find_files = {
      follow = true,
      hidden = true,
    }
  },
})
