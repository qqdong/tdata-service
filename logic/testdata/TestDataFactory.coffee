whenjs=require('when')

testDataTable=require('../../table/TestData.coffee')
TestDataModel=require('./TestData.coffee').TestData
errorCode=require('../../lib/error_code.coffee')

class  TestDataFactory
  constructor:()->

    #获取处理过的数据
  @getProcessedData: (beginTime,endTime)->
    resultList = []
    testDataTable.findProcessedData(beginTime,endTime)
    .then (tableList)->
      if not tableList?
        return []
      whenjs.map tableList, (tableItem, index)->
        TestDataModel model = new TestDataModel()
        model.setTestDataTable(tableItem)
        resultList[index] = model
    .then ()->
      return resultList

   #批量添加
  @bulkAdd:(params)->
    testDataTable.bulkAdd(params)

  @getNextNewData:()->
    testDataTable.findNextNewData()
    .then (tableTestData)->
      if not tableTestData?
        return null
      else
        TestDataModel model = new TestDataModel()
        model.setTestDataTable(tableTestData)
        return model

exports.TestDataFactory=TestDataFactory