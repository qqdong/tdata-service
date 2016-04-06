whenjs=require('when')

dayExcelRecordTable=require('../../table/DayExcelRecord.coffee')
DayExcelRecord=require('./../dayExcelRecord/DayExcelRecord.coffee').DayExcelRecord
errorCode=require('../../lib/error_code.coffee')

class  DayExcelRecordFactory
  constructor:()->

    #根据id获取
  @getById: (id)->
    dayExcelRecordTable.findById(id)
    .then (tableRecord)->
      DayExcelRecord record = new DayExcelRecord()
      record.setDayExcelRecordTable(tableRecord)
      return record

  @getByParams: (params)->
    resultList = []
    dayExcelRecordTable.findByParams(params)
    .then (tableList)->
      if not tableList?
        return []
      whenjs.map tableList, (tableItem, index)->
        DayExcelRecord record = new DayExcelRecord()
        record.setDayExcelRecordTable(tableItem)
        resultList[index] = record
    .then ()->
      return resultList

  @getCountByParams: (params)->
    dayExcelRecordTable.getCountByParams(params)


   #添加
  @add:(day,fileName)->
    dayExcelRecordTable.add(day,fileName)


exports.DayExcelRecordFactory=DayExcelRecordFactory