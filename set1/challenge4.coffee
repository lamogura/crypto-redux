Helpers = require('../support')
fs = require 'fs'

describe 'challenge 4', ->
  it 'finds and cracks XOR cipher from file', (done) ->
    # console.time('challenge4')
    fs.readFile './set1/challenge4.txt', 'utf-8', (err, fileData) ->
      
      bestCandidate = {score: 0}

      for line in fileData.split('\n')
        bestResult = Helpers.decodeXORCipher(new Buffer(line, 'hex'))

        if bestResult.score > bestCandidate.score
          bestCandidate = bestResult
          bestCandidate.cipherText = line

      # console.timeEnd('challenge4')
      # console.log require('util').inspect bestCandidate
      expect(bestCandidate.cipherText).toEqual('7b5a4215415d544115415d5015455447414c155c46155f4058455c5b523f')
      expect(bestCandidate.key).toEqual('5')
      done()
