inspect = require('util').inspect

XOR = (buffer1, buffer2) ->
  if !Buffer.isBuffer(buffer1) then throw new Error('Invalid buffer1: ' + inspect(buffer1))
  if !Buffer.isBuffer(buffer2) then throw new Error('Invalid buffer2: ' + inspect(buffer2))
  if buffer1.length isnt buffer2.length then throw new Error('Buffers not equal length!')
  
  result = []
  result.push(buffer1[i] ^ buffer2[i]) for i in [0...buffer1.length]

  return new Buffer(result)

describe 'challenge2', ->

  describe 'XOR()', ->
    it 'throws error if buffers not same length', ->
      fn = -> XOR(new Buffer([1,2]), new Buffer([1,2,3]))
      expect(fn).toThrowError(/equal length/i)

    it 'throws error if non buffer passed', ->
      fn = -> XOR(new Buffer([1,2]), 'not a buffer')
      expect(fn).toThrowError(/invalid/i)

    it 'can XOR 2 buffers of equal length', ->
      b1 = new Buffer('1c0111001f010100061a024b53535009181c', 'hex')
      b2 = new Buffer('686974207468652062756c6c277320657965', 'hex')
      result = XOR(b1, b2)
      expect(result.toString('hex')).toEqual('746865206b696420646f6e277420706c6179')
