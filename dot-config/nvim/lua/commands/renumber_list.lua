vim.api.nvim_create_user_command('RenumberList', function(opts)
  local start_line = opts.line1
  local end_line = opts.line2
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  local stack = {}

  for i, line in ipairs(lines) do
    local prefix, rest = line:match('^(%s*)%d+%.%s(.*)')
    if prefix and rest then
      local indent = #prefix

      -- Pop levels deeper than current
      while #stack > 0 and stack[#stack].indent > indent do
        table.remove(stack)
      end

      if #stack == 0 or stack[#stack].indent < indent then
        -- New deeper level
        table.insert(stack, { indent = indent, counter = 1 })
      else
        -- Same level, increment
        stack[#stack].counter = stack[#stack].counter + 1
      end

      lines[i] = prefix .. stack[#stack].counter .. '. ' .. rest
    end
  end

  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end, { range = true })
