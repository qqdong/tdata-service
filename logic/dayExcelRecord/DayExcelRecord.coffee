dayExcelRecordTable=require('../../table/DayExcelRecord.coffee')

class DayExcelRecord
  constructor:()->
    @tableDayExcelRecord = null

  setDayExcelRecordTable: (tableDayExcelRecord)->
    @tableDayExcelRecord = tableDayExcelRecord

  getDayExcelRecordTable: ()->
    return @tableDayExcelRecord

  getId: ()->
    return @tableDayExcelRecord.getDataValue('id')

  getDay: ()->
    return @tableDayExcelRecord.getDataValue('day')

  getFileName: ()->
    return @tableDayExcelRecord.getDataValue('file_name')


exports.DayExcelRecord=DayExcelRecord