answer = '0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f'

describe 'challenge 5', ->
  it 'does repeating key XOR encryption', ->
    plainText = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"
    key = 'ICE'

    cipherText = (new Buffer(plainText, 'utf8')).XOR(new Buffer(key, 'utf8'))

    expect(cipherText.toString('hex')).toEqual(answer)
