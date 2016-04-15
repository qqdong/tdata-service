schedule = require 'node-schedule'
moment = require 'moment'
whenjs=require 'when'

TestDataFactory = require('../testdata/TestDataFactory.coffee').TestDataFactory
DayExcelRecordFactory=require('../dayExcelRecord/DayExcelRecordFactory.coffee').DayExcelRecordFactory
ExcelProcess = require('../testdata/ExcelProcess.coffee').ExcelProcess
config = require('../../config.coffee')

#每天中午12点执行 '0 0 12 * * *'
#生成之前24小时内被处理的测试数据，包括状态为successed和failed的数据
schedule.scheduleJob '0 15 20 * * *', ()->
  console.log 'export testData of day execute ......'
  beginTime = null
  endTime = null
  filePath = ""
  rows = [] #保存到Excel中的数据
  whenjs().then ()->
    endTime = moment().minutes(0)
    beginTime = moment().add(-1, 'days').minutes(0)
    dayStr = beginTime.format('YYYY-MM-DD')
    fileName="testDataOfDay_" + dayStr + ".xlsx"
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
        rows.push row
    .then ()->
      ExcelProcess.save(filePath,rows)
    .then ()-> #保存到数据库
      DayExcelRecordFactory.add(dayStr,fileName)