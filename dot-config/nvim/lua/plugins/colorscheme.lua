return {
  {
    "nordtheme/vim",
    -- "gbprod/nord.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      -- require("nord").setup({})
      -- vim.cmd.colorscheme("nord")
    end,
  },

  {
    'AlexvZyl/nordic.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      nordic = require('nordic')
      nordic.setup({
        bright_border = true,
        telescope = {
          style = 'classic',
        }
      })
    end
  },
}
