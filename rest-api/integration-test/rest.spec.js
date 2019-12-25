const axios = require('axios')
const api_url = process.env.REST_API_URL

function wrapCommand(fn) {
  return (...args) => {
    return fn(...args).catch(err => {
      const util = require('util')
      console.log(util.inspect(err, true, null))
      throw err
    })
  }
}

describe('rest api', () => {
  test('analyze api', wrapCommand(async () => {
    const ret = await axios.post(`${api_url}/es`, {
      analyzer: 'standard',
      text: 'The quick Fox'
    })
    expect(ret.data).toEqual([
      { token: 'the', type: '<ALPHANUM>'},
      { token: 'quick', type: '<ALPHANUM>'},
      { token: 'fox', type: '<ALPHANUM>'}
    ])
  }))

  test('analyze api', wrapCommand(async () => {
    const ret = await axios.post(`${api_url}/es`, {
      analyzer: 'english',
      text: 'The quick Fox'
    })
    expect(ret.data).toEqual([
      { token: 'quick', type: '<ALPHANUM>'},
      { token: 'fox', type: '<ALPHANUM>'}
    ])
  }))
})
