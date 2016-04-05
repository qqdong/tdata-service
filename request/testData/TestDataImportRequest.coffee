ErrorCode = require '../../lib/error_code.coffee'
BaseRequest = require('./../BaseRequest.coffee').BaseRequest


TestDataFactory = require('../../logic/testdata/TestDataFactory.coffee').TestDataFactory
ExcelProcess=require('../../logic/testdata/ExcelProcess.coffee').ExcelProcess

class TestDataImportRequest extends BaseRequest

  constructor: (req, res, next)->
    super req, res, next
    params = req.body
    console.log req.files
    {file} = req.files
    @file = file
    @params = params

  _execute: ->
    request = this
    rows=[]
    ExcelProcess.parse(request.file.path)
    .then (excelRows)->
      for excelRow in excelRows
        row={}
        row.name=excelRow[0]
        row.type=excelRow[1]
        row.upload_date=new Date()
        rows.push row
      TestDataFactory.bulkAdd(rows)
    .then ()->
      return {url: "url"}

  #去除已存在的name


exports.TestDataImportRequest = TestDataImportRequest


