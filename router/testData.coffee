express = require 'express'
router = express.Router()
multipart = require 'connect-multiparty'


module.exports = exports = router

config=require('../config.coffee')
TestDataImportRequest = require('../request/testData/TestDataImportRequest.coffee').TestDataImportRequest
GetNextNewDataRequest = require('../request/testData/GetNextNewDataRequest.coffee').GetNextNewDataRequest
UpdateDataStatusRequest = require('../request/testData/UpdateDataStatusRequest.coffee').UpdateDataStatusRequest


GetExcelRecordListRequest = require('../request/dayExcelRecord/GetExcelRecordListRequest.coffee').GetExcelRecordListRequest
GetExcelRecordCountRequest = require('../request/dayExcelRecord/GetExcelRecordCountRequest.coffee').GetExcelRecordCountRequest
DayExcelRecordFactory=require('../logic/dayExcelRecord/DayExcelRecordFactory.coffee').DayExcelRecordFactory

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

#每日导出列表
router.post '/export/list',multipart(),(req, res, next)->
  request = new GetExcelRecordListRequest req, res, next
  request.render()
router.post '/export/count',multipart(),(req, res, next)->
  request = new GetExcelRecordCountRequest req, res, next
  request.render()

#下载
router.get '/export/download/:id',(req,res,next)->
  DayExcelRecordFactory.getById(req.params.id)
  .then (record)->
    console.log record
    realpath=config.exportExcelPath + "/"+record.getFileName()
    res.download(realpath,record.getFileName());