-- obsidian.nvim exposes sync state via require("obsidian.sync.status") but
-- never renders it. Show its icon in the statusline. The module isn't loaded
-- until the plugin sets up, so require lazily inside the component.
local function obsidian_sync()
  local ok, status = pcall(require, 'obsidian.sync.status')
  if not ok then return '' end
  return status.icon()
end

local function config()
  require('lualine').setup {
    options = {
      theme = 'auto'
    },
    sections = {
      lualine_c = {
        {'filename', path = 1} -- 0 = just name, 1 = relative path, 2 = absolute path
      },
      -- Right group. Specifying lualine_x overrides its defaults, so the stock
      -- components are restored here alongside the sync icon.
      lualine_x = {
        {
          obsidian_sync,
          -- status.color() returns a highlight group (ObsidianSyncSynced etc.,
          -- linked to Diagnostic{Ok,Warn,Info,Error}); lualine accepts a group name.
          color = function()
            local ok, status = pcall(require, 'obsidian.sync.status')
            return ok and status.color() or nil
          end,
        },
        'encoding',
        'fileformat',
        'filetype',
      },
    }
  }

  -- The plugin fires this when sync state changes; refresh so the icon updates
  -- immediately instead of waiting for lualine's poll interval.
  vim.api.nvim_create_autocmd('User', {
    pattern = 'ObsidianSyncChanged',
    callback = function() require('lualine').refresh() end,
  })
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = config,
}
