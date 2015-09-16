require('../support')

describe 'challenge2', ->

  describe 'buffer.XOR()', ->
    it 'throws error if non buffer passed', ->
      fn = -> (new Buffer([1,2])).XOR('not a buffer')
      expect(fn).toThrowError(/invalid/i)

    it 'can XOR 2 buffers of equal length', ->
      b1 = new Buffer('1c0111001f010100061a024b53535009181c', 'hex')
      b2 = new Buffer('686974207468652062756c6c277320657965', 'hex')
      result = b1.XOR(b2)
      expect(result.toString('hex')).toEqual('746865206b696420646f6e277420706c6179')
