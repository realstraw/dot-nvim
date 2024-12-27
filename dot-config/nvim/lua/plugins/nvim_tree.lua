local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- -- custom mappings
  vim.keymap.set('n', 'i', api.node.open.horizontal, opts('Open: Horizontal Split'))
end

return {

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
		config = function()
      require("nvim-tree").setup {
        on_attach = on_attach,
        view = {
          adaptive_size = true,
        },
        filters = { custom = { "^.git$" } },
      }
		end,
    keys = {
      {"<C-l>", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle Tre"},
    }
  },

}
