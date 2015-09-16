Helpers = require('../support')

describe 'challenge 3', ->
  it 'cracks XOR', ->
    cipher = new Buffer('1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736', 'hex')

    bestResult = Helpers.decodeXORCipher(cipher)

    # console.log "cipherText was XOR decoded with '#{bestResult.key}' yielding -> '#{bestResult.decoded}'"
    expect(bestResult.key).toEqual('X')
