express = require 'express'
router = express.Router()
multipart = require 'connect-multiparty'


module.exports = exports = router

TestDataImportRequest = require('../request/testData/TestDataImportRequest.coffee').TestDataImportRequest

#导入
router.post '/import',multipart(),(req, res, next)->
  request = new TestDataImportRequest req, res, next
  request.render()