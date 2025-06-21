local lib = require 'invert.lib'

describe('clamp', function()
  it('clamps -10 to 0 < x < 10', function()
    assert.are.equal(0, lib.clamp(-10, 0, 10))
  end)

  it('clamps 100 to 23 < x < 42', function()
    assert.are.equal(23, lib.clamp(100, 23, 42))
  end)
end)
