const express = require('express')
const app = express()

app.get('/', (req, res) => res.send('Hello from nodeapp!'))

app.listen(80, () => console.log('Example app listening on port 80!'))
