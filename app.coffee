process.chdir(__dirname)

_ = require("lodash")
os = require 'os'
express = require("express")
path = require("path")
compress = require("compression")
require "date-format-lite"

logger = require("./lib/logger") __filename
config = require("./config")
router = require("./router/index")

#内存监视
memwatch = require('memwatch-next')
memwatch.on 'leak', (info)->
  console.log info

memwatch.on 'stats', (info)->
  console.log info

#实例化app
app = express()
app.use '/health-check', (req, res) ->
  res.send 'OK'

app.use compress()
app.use router

#创建并启动服务
server = null
if config.useHttps
  https = require("https")
  fs = require("fs")
  option = 
    key: fs.readFileSync('./ssl_file/muse.key')
    cert: fs.readFileSync('./ssl_file/muse.crt')
  server = https.createServer(option, app)
else 
  http = require("http")
  server = http.createServer(app)
server.setMaxListeners 100

server.listen config.port, '0.0.0.0', () ->
  console.log config.env + ": server listening on #{config.port}"

process.on 'uncaughtException', (err) ->
  logger.error err

module.exports = exports = app
