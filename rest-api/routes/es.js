var express = require('express');
var router = express.Router();

const { Client } = require('@elastic/elasticsearch');
const client = new Client({ node: process.env.ES_URL });

/* GET users listing. */
router.post('/', async function(req, res, next) {
  try {
    console.log(req.body)
    res.json(await analyze(req.body));
  } catch(err) {
    res.status(500)
    res.json({error: err})
  }
});

async function analyze({ analyzer, text }) {
  let ret = await client.indices.analyze({
    body: {
      analyzer, text
    }
  });
  const tokens = ret.body.tokens.map(e => {
    return {
      token: e.token,
      type: e.type
    }
  })
  console.log(tokens)
  return Array.isArray(tokens) ? tokens : [tokens]
}

module.exports = router;
