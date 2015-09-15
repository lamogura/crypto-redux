hexToBase64 = (hex) ->
  buf = new Buffer(hex, 'hex')
  return buf.toString('base64')

describe 'challenge1', ->
  it 'converts hex to base64', ->
    hex = '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'
    expect(hexToBase64(hex)).toEqual('SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t')