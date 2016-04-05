whenjs=require("when")

errorCode = require '../../lib/error_code.coffee'
BaseRequest = require('./../BaseRequest.coffee').BaseRequest


TestDataFactory = require('../../logic/testdata/TestDataFactory.coffee').TestDataFactory
ExcelProcess = require('../../logic/testdata/ExcelProcess.coffee').ExcelProcess
TDataSequelize = require '../../table/tdata_sequelize.coffee'

class TestDataImportRequest extends BaseRequest

  constructor: (req, res, next)->
    super req, res, next
    params = req.body
    throw  errorCode.commonError.parameterError unless req.files?
    {file} = req.files
    throw  errorCode.commonError.parameterError unless file?
    @file = file
    @params = params

  _execute: ->
    request = this
    TDataSequelize.transaction()
    .then (trans)->
      ExcelProcess.parse(request.file.path)
      .then (excelRows)->
        request._parseExcelRows(excelRows)
      .then (rows)->
        TestDataFactory.bulkAdd(rows)
      .then (result)->
        trans.commit()
        return {}
      .catch (error)->
        trans.rollback()
        throw errorCode.testDataError.excelFormatError

  _parseExcelRows: (excelRows)->
    rows=[]
    request=this
    index=0
    whenjs().then ()->
      for excelRow in excelRows
        index++
        if(index == 1 || request._haveRepartName(rows, excelRow[0])==1)  #去除第一行和重复项
          continue
        row = {}
        row.name = excelRow[0]
        row.type = excelRow[1]
        row.upload_date = new Date()
        rows.push row
    .then ()->
      return rows

  #是否包含已存在的name
  _haveRepartName: (rows, name)->
    isHave = 0
    for row in rows
      if row.name == name
        isHave = 1
        break
    return isHave


exports.TestDataImportRequest = TestDataImportRequest


