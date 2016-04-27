schedule = require 'node-schedule'
moment = require 'moment'
whenjs=require 'when'

TestDataFactory = require('../testdata/TestDataFactory.coffee').TestDataFactory
DayExcelRecordFactory=require('../dayExcelRecord/DayExcelRecordFactory.coffee').DayExcelRecordFactory
ExcelProcess = require('../testdata/ExcelProcess.coffee').ExcelProcess
config = require('../../config.coffee')

#每天凌晨0点执行 '0 0 0 * * *'
#生成之前12小时内被处理的测试数据，包括状态为successed和failed的数据
schedule.scheduleJob '0 0 0 * * *', ()->
  console.log 'export testData of day execute ......'
  beginTime = null
  endTime = null
  whenjs().then ()->
    endTime = moment().minutes(0)
    beginTime = moment().add(-12, 'hours').minutes(0)
    dayStr = endTime.format('YYYYMMDD')+"_1"
    fileName=dayStr + ".xlsx"
    _generateExcel(beginTime,endTime,fileName,dayStr)

#每天中午12点执行 '0 0 12 * * *'
#生成之前12小时内被处理的测试数据，包括状态为successed和failed的数据
schedule.scheduleJob '0 0 12 * * *', ()->
  console.log 'export testData of day execute ......'
  beginTime = null
  endTime = null
  whenjs().then ()->
    endTime = moment().minutes(0)
    beginTime = moment().add(-12, 'hours').minutes(0)
    dayStr = endTime.format('YYYYMMDD')+"_2"
    fileName=dayStr + ".xlsx"
    _generateExcel(beginTime,endTime,fileName,dayStr)


_generateExcel=(beginTime,endTime,fileName,dayStr)->
  filePath = ""
  rows = [] #保存到Excel中的数据
  whenjs().then ()->
    filePath = config.exportExcelPath + "/"+fileName
    TestDataFactory.getProcessedData(beginTime.format('YYYY-MM-DD HH:mm'), endTime.format('YYYY-MM-DD HH:mm'))
    .then (records)->
      if records == null
        return
      for record in records
        row = []
        row.push record.getName()
        row.push record.getType()
        row.push record.getStatus()
        row.push record.getUploadDateStr()
        row.push record.getProcessDateStr()
        row.push record.getClientId()
        rows.push row
    .then ()->
      ExcelProcess.save(filePath,rows)
    .then ()-> #保存到数据库
      DayExcelRecordFactory.add(dayStr,fileName)