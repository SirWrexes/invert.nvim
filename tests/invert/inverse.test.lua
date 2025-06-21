local Inverse = require 'invert.Inverse'

describe('Inverse', function()
  it('Should create a proper inverse table', function()
    local inverses = {
      ['cringe'] = 'based',
      ['mayo'] = 'ketchup',
      ['burger'] = 'salad',
    }
    local iv = Inverse:new(inverses)
    assert.are.same(rawget(iv, '_inverses'), inverses)
    assert.are.equal(iv['cringe'], 'based')
    assert.are.equal(iv['salad'], 'burger')
  end)
end)
