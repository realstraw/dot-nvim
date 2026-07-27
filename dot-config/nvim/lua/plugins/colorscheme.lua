return {
  {
    "f-person/auto-dark-mode.nvim",
    -- Register before any colorscheme is applied so the first nord load is
    -- covered. A ColorScheme autocmd re-applies on every load, surviving the
    -- dark/light toggle (config would only run once).
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "nord",
        callback = function()
          -- nord's default Special (#d8dee9) is near-white and hard to see.
          vim.api.nvim_set_hl(0, "Special", { fg = "#a3be8c" }) -- nord14 green
        end,
      })
    end,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme("nord")
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd.colorscheme("iceberg")
      end,
    },
  },

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
        },
        visual = {
          theme = 'light',
        },
        cursorline = {
          theme = 'light',
        }
      })
    end
  },

  {
    "alexxGmZ/e-ink.nvim",
    lazy = true,
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

  {
    "cocopon/iceberg.vim",
    lazy = true,
    priority = 1000,
  },

  {
    "sainnhe/everforest",
    lazy = true,
    priority = 1000,
  },

  {
    "webhooked/kanso.nvim",
    lazy = true,
    priority = 1000,
  },
}
