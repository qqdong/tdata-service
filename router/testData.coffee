express = require 'express'
router = express.Router()
multipart = require 'connect-multiparty'


module.exports = exports = router

TestDataImportRequest = require('../request/testData/TestDataImportRequest.coffee').TestDataImportRequest
GetNextNewDataRequest = require('../request/testData/GetNextNewDataRequest.coffee').GetNextNewDataRequest
UpdateDataStatusRequest = require('../request/testData/UpdateDataStatusRequest.coffee').UpdateDataStatusRequest


#导入
router.post '/import',multipart(),(req, res, next)->
  request = new TestDataImportRequest req, res, next
  request.render()

#获取下一条测试数据
router.post '/getName',(req, res, next)->
  request = new GetNextNewDataRequest req, res, next
  request.render()

#更新测试数据状态
router.post '/updateStatus',(req, res, next)->
  request = new UpdateDataStatusRequest req, res, next
  request.render()