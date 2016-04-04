testDataTable=require('../../table/TestData.coffee')
moment=require('moment')

class TestData
  constructor:()->
    @tableTestData = null

  setTestDataTable: (tableTestData)->
    @tableTestData = tableTestData

  getTestDataTable: ()->
    return @tableTestData

  getId: ()->
    return @tableTestData.getDataValue('id')

  getName: ()->
    return @tableTestData.getDataValue('name')

  getType: ()->
    return @tableTestData.getDataValue('type')

  getStatus: ()->
    return @tableTestData.getDataValue('status')

  getUploadDate: ()->
    return @tableTestData.getDataValue('upload_date')

  getProcessDate: ()->
    return @tableTestData.getDataValue('process_date')

  getUploadDateStr: ()->
    uploadDate=@getUploadDate()
    return moment(uploadDate).format('YYYY-MM-DD HH:mm:ss')

  getProcessDateStr: ()->
    processDate=@getProcessDate()
    return moment(processDate).format('YYYY-MM-DD HH:mm:ss')


  getIsDownload: ()->
    return @tableTestData.getDataValue('is_download')

exports.TestData=TestData