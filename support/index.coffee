inspect = require('util').inspect

Buffer.prototype.XOR = (otherBuffer) ->
  if !Buffer.isBuffer(otherBuffer) then throw new Error('Invalid otherBuffer: ' + inspect(otherBuffer))
  if this.length isnt otherBuffer.length then throw new Error('Buffers not equal length!')
  
  result = []
  result.push(this[i] ^ otherBuffer[i]) for i in [0...this.length]
  return new Buffer(result)

Buffer.prototype.XORR = (otherBuffer) ->
  sameLengthBuff = new Buffer(0)
  while sameLengthBuff.length < this.length
    sameLengthBuff = Buffer.concat([sameLengthBuff, otherBuffer])
  sameLengthBuff = sameLengthBuff.slice(0, this.length)
  return this.XOR(sameLengthBuff)

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

Helpers.scoreString = (str) ->
  str = str.toLowerCase()
  monogramValue = 0.1
  bigramValue = 1
  trigramValue = 2.5

  score = 0
  for i in [0..str.length]
    score += monogramValue if (str.charCodeAt(i) > 65 && str.charCodeAt(i) < 122)
  bigrams.forEach (b) -> score += bigramValue * occurrences(str, b)
  trigrams.forEach (t) -> score += trigramValue * occurrences(str, t)
  # console.log("#{score}: #{str}")
  return score

module.exports = Helpers
