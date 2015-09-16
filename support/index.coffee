inspect = require('util').inspect

Buffer.prototype.XOR = (buf) ->
  if !Buffer.isBuffer(buf) then throw new Error('Invalid buf: ' + inspect(buf))

  xorBytes = []
  for i in [0...this.length]
    xorBytes.push(this[i] ^ buf[i % buf.length])

  return new Buffer(xorBytes)

Helpers = {}

bigrams  = ['th','en','ng','he','ed','of','in','to','al','er','it','de','an','ou','se','re','ea','le','nd','hi','sa','at','is','si','on','or','ar','nt','ti','ve','ha','as','ra','es','te','ld','st','et','ur']
trigrams = ['the','and','tha','ent','ing','ion','tio','for','nde','has','nce','edt','tis','oft','sth','men']

occurrences = (string, subString, allowOverlapping) ->
  if (subString.length <= 0) then return 0
  n = 0
  pos = 0
  step = if allowOverlapping then 1 else subString.length

  while true
    pos = string.indexOf(subString, pos)
    if pos >= 0 
      ++n
      pos += step 
    else break
  return n

isEnglishAlphabet = (charCode) ->
  return 0x41 <= charCode <= 0x5A

isCommonChar = (charCode) ->
  return 0x20 <= charCode <= 0x7D

Helpers.scoreString = (str) ->
  lowerStr = str.toLowerCase()
  monogramValue = 0.1
  bigramValue = 1
  trigramValue = 2.5

  score = 0
  for i in [0..lowerStr.length]
    monogramCode = lowerStr.charCodeAt(i)
    if isCommonChar(monogramCode)
      score += monogramValue
      if isEnglishAlphabet(monogramCode)
        score += monogramValue
    else
      score -= monogramValue

  bigrams.forEach (b) -> score += bigramValue * occurrences(lowerStr, b)
  trigrams.forEach (t) -> score += trigramValue * occurrences(lowerStr, t)
  # console.log("#{score}: #{str}") if score > 8
  return score

Helpers.decodeXORCipher = (cipher) ->
  start = 'A'.charCodeAt(0)
  end = 'z'.charCodeAt(0)

  bestResult = {score: 0}

  for i in [0..128]
    key = String.fromCharCode(i)
    decoded = cipher.XOR(new Buffer(key)).toString('utf8')
    score = Helpers.scoreString(decoded)
    
    if score > bestResult.score
      bestResult = {key: key, decoded: decoded, score: score}

  return bestResult

module.exports = Helpers
