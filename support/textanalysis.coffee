letterFreq = { a: 0.08167, b: 0.01492, c: 0.02782, d: 0.04253, e: 0.12702, f: 0.02228, g: 0.02015, h: 0.06094, i: 0.06966, j: 0.00153, k: 0.00772, l: 0.04025, m: 0.02406, n: 0.06749, o: 0.07507, p: 0.01929, q: 0.00095, r: 0.05987, s: 0.06327, t: 0.09056, u: 0.02758, v: 0.00978, w: 0.02361, x: 0.00150, y: 0.01974, z: 0.00074}
bigrams  = ['th','en','ng','he','ed','of','in','to','al','er','it','de','an','ou','se','re','ea','le','nd','hi','sa','at','is','si','on','or','ar','nt','ti','ve','ha','as','ra','es','te','ld','st','et','ur']
trigrams = ['the','and','tha','ent','ing','ion','tio','for','nde','has','nce','edt','tis','oft','sth','men']

module.exports = {
  scoreStringBirams: (str) ->
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

  scoreStringByHistogram: (str) ->
    lowerStr = str.toLowerCase()

    hist = getLetterHistogram(lowerStr)

    sum = 0
    for letter of letterFreq
      diff = letterFreq[letter] - (hist[letter] or 0)
      sum += Math.pow(diff, 2)
      delete hist[letter]

    rss = 1 / Math.sqrt(sum)

    for letter of hist
      # console.log letter
      if isCommonChar(letter)
        rss *= 0.9
      else 
        rss *= 0.8

    # if rss > 4
    # console.log "score: #{rss}"
      # console.dir hist
    return rss
}

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
  if typeof(charCode) is 'string'
    charCode = charCode.charCodeAt(0)
  return 0x41 <= charCode <= 0x5A

isCommonChar = (charCode) ->
  if typeof(charCode) is 'string'
    charCode = charCode.charCodeAt(0)
  return 0x20 <= charCode <= 0x7D

getLetterHistogram = (str) ->
  str = str.toLowerCase()
  hist = {}
  for c in str
    if hist[c] then hist[c]++
    else hist[c] = 1

  len = str.length
  for key of hist
    hist[key] = hist[key] / len

  return hist
  