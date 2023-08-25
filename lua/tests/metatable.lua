do
  local table = setmetatable({
    name = 'name',
  }, {
    __index = function(t, key)
      vim.pretty_print(t)
      vim.pretty_print(key)
    end,
  })

  print(table.name)
  _ = table.ok
end

do
  local table = {
    rust = true,
  }

  if table.rust then
    print 'RUST OK'
  end

  if table.go then
    print 'GO OK'
  else
    print 'GO NO'
  end
end
