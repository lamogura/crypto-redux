Text    = require('../support/textanalysis')
Helpers = require('../support')
fs      = require('fs')

describe 'challenge 6', ->
  it 'calculates hamming distance', ->
    ham = (new Buffer('this is a test')).hammingDistance(new Buffer('wokka wokka!!!'))
    expect(ham).toEqual(37)

  xit 'cracks repeating key XOR cipher from file', (done) ->
    # console.time('challenge6')
    # console.timeEnd('challenge6')
    fs.readFile './set1/challenge6.txt', 'utf-8', (err, fileData) ->
      cipher = new Buffer(fileData, 'base64')

      # keySize = guessKeySize(cipher).keySize
      # console.log "Guessed keySize=#{keySize} from edit distance of first few chunks"
      # expect(keySize).toEqual(5)

      decodedBlocks = transpose(cipher, 5).map (block) ->
        bestResult = Helpers.decodeXORCipher(block, Text.scoreStringByHistogram)
        bestResult.decoded
      # console.dir decodedBlocks
      
      plainText = ''
      for i in [0...decodedBlocks[0].length]
        text = ''
        for j in [0...decodedBlocks.length]
          if i < decodedBlocks[j].length
            text += decodedBlocks[j][i]
        plainText += text

      console.log "plainText: " + plainText.slice(0, 50) + "..."

      done()

sliceChunks = (cipher, length, take) ->
  nextIdx = 0
  chunks = []
  for i in [0...take]
    nextIdx = i*length
    chunks.push(cipher.slice(nextIdx, nextIdx+length))

  return chunks

guessKeySize = (cipher) ->
  bestResult = {distance: 100}
  for keySize in [2..40]
    [chunk1, chunk2, chunk3, chunk4] = sliceChunks(cipher, keySize, 4)
    distance1 = chunk1.hammingDistance(chunk2) / keySize
    distance2 = chunk1.hammingDistance(chunk3) / keySize
    distance3 = chunk1.hammingDistance(chunk4) / keySize
    distance = (distance1 + distance2 + distance3) / 3

    if distance < bestResult.distance
      bestResult = {distance: distance, keySize: keySize}

  return bestResult

transpose = (cipher, keyLength) ->
  # make array where each item N is an array of every Nth byte of the cipher
  transposed = []
  for i in [0...cipher.length]
    idx = i % keyLength
    if transposed[idx] then transposed[idx].push(cipher[i])
    else transposed[idx] = [cipher[i]]

  return transposed.map (x) -> new Buffer(x)
