require('lualine').setup {
  options = {
    theme = 'nord'
  },
  sections = {
    lualine_c = {
      {'filename', path = 1} -- 0 = just name, 1 = relative path, 2 = absolute path
    }
  }
}
