inspect = require('util').inspect

Buffer.prototype.XOR = (buf) ->
  if !Buffer.isBuffer(buf) then throw new Error('Invalid buf: ' + inspect(buf))

  xorBytes = []
  for i in [0...this.length]
    xorBytes.push(this[i] ^ buf[i % buf.length])

  return new Buffer(xorBytes)

Buffer.prototype.hammingDistance = (buf) ->
  if this.length isnt buf.length then throw new Error('Buffers must be same length!')
  if !Buffer.isBuffer(buf) then throw new Error('Invalid buf: ' + inspect(buf))

  # XOR the 2 buffers, which leaves a 1 bit in all the bits they differed
  # then just count the 1 bits
  count = 0
  for byte in this.XOR(buf)
    while byte > 0
      count += byte & 1
      byte = byte >> 1

  return count