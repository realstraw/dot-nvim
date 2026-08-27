-- obsidian.nvim exposes sync state via require("obsidian.sync.status") but
-- never renders it. Show its icon in the statusline.
--
-- Guard on the Obsidian global (created by obsidian.setup()) before requiring:
-- lazy.nvim hooks require(), so requiring an obsidian module force-loads the
-- plugin in every session, defeating its cmd/keys lazy-loading. pcall doesn't
-- help — the load happens inside require, before it can fail. The icon stays
-- blank until an :Obsidian command loads the plugin.
local function obsidian_sync()
  if not Obsidian then return '' end
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
          -- linked to Diagnostic{Ok,Warn,Info,Error}). Handing lualine the group
          -- name pulls in that group's background too — and some light themes
          -- tint the Diagnostic backgrounds, which shows as a colored block
          -- behind the icon. Resolve just the foreground and return it as a
          -- table so lualine keeps the statusline section's own background.
          color = function()
            if not Obsidian then return nil end
            local ok, status = pcall(require, 'obsidian.sync.status')
            if not ok then return nil end
            local hl = vim.api.nvim_get_hl(0, { name = status.color(), link = false })
            return hl.fg and { fg = string.format('#%06x', hl.fg) } or nil
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
