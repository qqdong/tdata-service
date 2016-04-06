whenjs=require("when")

errorCode = require '../../lib/error_code.coffee'
BaseRequest = require('./../BaseRequest.coffee').BaseRequest
BaseParam=require('../../logic/param/BaseQueryParam.coffee').BaseQueryParam

DayExcelRecordFactory = require('../../logic/dayExcelRecord/DayExcelRecordFactory.coffee').DayExcelRecordFactory

class GetExcelRecordCountRequest extends BaseRequest

  constructor: (req, res, next)->
    super req, res, next
    params = req.body
    @params = params

  _execute: ->
    request = this
    resultArray=[]
    DayExcelRecordFactory.getCountByParams(request.params)
    .then (count)->
      return {count: count}


exports.GetExcelRecordCountRequest = GetExcelRecordCountRequest


