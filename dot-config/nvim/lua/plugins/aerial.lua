return {
  "stevearc/aerial.nvim",
  cmd = { "AerialToggle", "AerialOpen", "AerialClose", "AerialNavToggle", "AerialInfo" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>o", "<cmd>AerialToggle<CR>", desc = "Toggle code outline" },
  },
  opts = {
    attach_mode = "global",
    layout = {
      default_direction = "right",
      placement = "edge",
    },
  },
}
