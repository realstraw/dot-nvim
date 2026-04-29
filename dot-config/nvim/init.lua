require("config.lazy")
require("commands.renumber_list")

-- vim.cmd.colorscheme("nord")
-- vim.cmd.colorscheme("iceberg")
-- vim.g.everforest_background = 'hard'
-- vim.cmd.colorscheme("everforest")
-- vim.cmd.colorscheme("nordic")
-- vim.cmd.colorscheme("e-ink")

vim.filetype.add({ extension = { mdx = 'markdown' } })

vim.o.guifont = "Hack Nerd Font Mono:h12"

if vim.g.neovide then
  -- disable animation
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0
end
