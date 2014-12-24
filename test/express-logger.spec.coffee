# load modules
logger = require('../index')
express = require("express")
app = express()
#logger.init()

# config
###
    AUTO LEVEL DETECTION
    http responses 3xx, level = WARN
    http responses 4xx & 5xx, level = ERROR
    else.level = INFOex
###
app.use(logger.expressLogger())

# route
app.get('/', (req,res) ->
    res.send('hello world')
)

# start app
app.listen(5000)

console.log('server runing at localhost:5000')
console.log('Simulation of normal response: goto localhost:5000')
console.log('Simulation of error response: goto localhost:5000/xxx')