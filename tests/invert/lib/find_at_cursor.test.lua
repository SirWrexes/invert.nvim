local lib = require 'invert.lib'

describe('find_in_line', function()
  it('finds match from inside word', function()
    local line = 'Biggy burger sauce'
    -- cursor               ^
    local cursor = 11
    local token = 'burger'
    local position = 7

    assert.are.equal(position, lib.find_at_cursor(line, cursor, token))
  end)

  it('finds match from start of word', function()
    local line = 'Biggy burger sauce'
    -- cursor           ^
    local cursor = 7
    local token = 'burger'
    local position = 7

    assert.are.equal(position, lib.find_at_cursor(line, cursor, token))
  end)

  it('finds match from end of word', function()
    local line = 'Biggy burger sauce'
    -- cursor                ^
    local cursor = 12
    local token = 'burger'
    local position = 7

    assert.are.equal(position, lib.find_at_cursor(line, cursor, token))
  end)

  it("doesn't find match beyond cursor", function()
    local line = 'boobies booba boobies'
    -- cursor              ^
    local cursor = 10
    local token = 'boobies'

    assert.is.Nil(lib.find_at_cursor(line, cursor, token))
  end)
end)
