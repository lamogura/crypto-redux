Text = require('./textanalysis')

Helpers = {}

Helpers.decodeXORCipher = (cipher, useHistogram) ->
  bestResult = {score: 0}

  for i in [0..128]
    decoded = cipher.XOR(new Buffer([i])).toString('utf8')

    if useHistogram
      score = Text.scoreStringByHistogram(decoded)
    else 
      score = Text.scoreStringBirams(decoded)

    if score > bestResult.score
      bestResult = {key: String.fromCharCode(i), decoded: decoded, score: score}

  # console.dir bestResult
  return bestResult

module.exports = Helpers
