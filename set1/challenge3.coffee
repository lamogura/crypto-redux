Helpers = require('../support')

describe 'challenge 3', ->
  it 'cracks XOR', ->
    cipherText = new Buffer('1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736', 'hex')

    start = 'A'.charCodeAt(0)
    end = 'z'.charCodeAt(0)

    bestResult = {score: 0}

    for i in [start..end]
      key = String.fromCharCode(i)
      decoded = cipherText.XORR(new Buffer(key)).toString('utf8')
      score = Helpers.scoreString(decoded)
      
      if score > bestResult.score
        bestResult = {key: key, decoded: decoded, score: score}

    # console.log "cipherText was XOR decoded with '#{bestResult.key}' yielding -> '#{bestResult.decoded}'"
    expect(bestResult.key).toEqual('X')
