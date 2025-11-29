local function config()
  require('telescope').setup({
    defaults = {
      -- mappings = {
      --   n  = {
      --     ["!"] = action_layout.toggle_preview,
      --   },
      -- },
      file_ignore_patterns = { "^%.git", "node_modules", ".next" }
    },
    pickers = {
      find_files = {
        follow = true,
        hidden = true,
        layout_strategy = 'vertical',
        layout_config = { width = 0.8 },
        -- theme = "dropdown",
      },
      buffers = {
        layout_strategy = 'vertical',
      },
      live_grep = {
        layout_strategy = 'vertical',
      },
    },
  })
end

return {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = config,
	keys = {
		-- nnoremap <Leader>ff <cmd>Telescope find_files<cr>
		{ "<Leader>ff", "<cmd>Telescope find_files<cr>" },
		-- nnoremap <Leader>,f <cmd>Telescope find_files<cr>
		{ "<Leader>,f", "<cmd>Telescope find_files<cr>" },
		-- nnoremap <Leader>fg <cmd>Telescope live_grep<cr>
		{ "<Leader>fg", "<cmd>Telescope live_grep<cr>" },
		-- nnoremap <Leader>,g <cmd>Telescope live_grep<cr>
		{ "<Leader>,g", "<cmd>Telescope live_grep<cr>" },
		-- nnoremap <Leader>fb <cmd>Telescope buffers<cr>
		{ "<Leader>fb", "<cmd>Telescope buffers<cr>" },
		-- nnoremap <Leader>,b <cmd>Telescope buffers<cr>
		{ "<Leader>,b", "<cmd>Telescope buffers<cr>" },
		-- nnoremap <Leader>fh <cmd>Telescope help_tags<cr>
		{ "<Leader>fh", "<cmd>Telescope help_tags<cr>" },
		-- nnoremap <Leader>,h <cmd>Telescope help_tags<cr>
		{ "<Leader>,h", "<cmd>Telescope help_tags<cr>" },
	},
}
