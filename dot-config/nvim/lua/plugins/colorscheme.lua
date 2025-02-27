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

  {
    "alexxGmZ/e-ink.nvim",
    priority = 1000,
    config = function ()
      require("e-ink").setup()
      -- vim.cmd.colorscheme "e-ink"

      -- choose light mode or dark mode
      -- vim.opt.background = "dark"
      -- vim.opt.background = "light"
      --
      -- or do
      -- :set background=dark
      -- :set background=light
    end
  },
}
