Helpers = require('../support')

describe 'challenge 3', ->
  it 'cracks XOR', ->
    hash = new Buffer('1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736', 'hex')
    # console.log hash.XOR(new Buffer('a')).toString('utf8')

    start = ("A").charCodeAt(0)
    end = 'z'.charCodeAt(0)

    bestResult = {score: 0}
    for i in [start..end]
      charKey = String.fromCharCode(i)
      decoded = hash.XORR(new Buffer(charKey)).toString('utf8')
      score = Helpers.scoreString(decoded)
      if score > bestResult.score
        bestResult = {key: charKey, decoded: decoded, score: score}

    # console.log "likely candidate was decoded with '#{bestResult.key}' yielding -> '#{bestResult.decoded}'"
    expect(bestResult.key).toEqual('X')

