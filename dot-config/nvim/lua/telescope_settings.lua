local action_layout = require("telescope.actions.layout")

require('telescope').setup({
  defaults = {
    mappings = {
      n  = {
        ["!"] = action_layout.toggle_preview,
      },
    },
    file_ignore_patterns = { "^%.git", "node_modules", ".next" }
  },
  pickers = {
    find_files = {
      follow = true,
      hidden = true,
      layout_strategy = 'vertical',
      layout_config = { width = 0.8 },
      -- theme = "dropdown",
    }
  },
})
