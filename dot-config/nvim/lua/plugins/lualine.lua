local function config()
  require('lualine').setup {
    options = {
      theme = 'nord'
    },
    sections = {
      lualine_c = { 'buffers' },
      lualine_x = {
        {'filename', path = 1}, -- 0 = just name, 1 = relative path, 2 = absolute path
        'encoding',
        'fileformat',
        'filetype'
      },
    }
  }
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = config,
}
