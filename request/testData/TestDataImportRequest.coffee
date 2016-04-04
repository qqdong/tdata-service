ErrorCode = require '../../lib/error_code.coffee'
BaseRequest = require('./../BaseRequest.coffee').BaseRequest


TestDataFactory = require('../../logic/testdata/TestDataFactory.coffee').TestDataFactory
ExcelProcess=require('../../logic/testdata/ExcelProcess.coffee').ExcelProcess

class TestDataImportRequest extends BaseRequest

  constructor: (req, res, next)->
    super req, res, next
    params = req.body
    {file} = req.files
    params.file=file
    @params = params

  _execute: ->
    request = this
    ExcelProcess.parse(request.params.file.path)
    .then (excelRows)->
      console.log excelRows
      #TestDataFactory.bulkAdd()
    .then (productList)->
      return null

exports.TestDataImportRequest = TestDataImportRequest


