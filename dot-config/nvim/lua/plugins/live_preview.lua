return {
  'brianhuster/live-preview.nvim',
  -- Only entry point is :LivePreview (start/close/pick subcommands), so load
  -- on that command. Its VimLeavePre cleanup autocmd registers on first use,
  -- which is fine since there's nothing to close until a preview is started.
  cmd = "LivePreview",
  dependencies = {
    -- You can choose one of the following pickers
    'nvim-telescope/telescope.nvim',
    -- 'ibhagwan/fzf-lua',
    -- 'echasnovski/mini.pick',
		-- 'folke/snacks.nvim',
  },
}
