whenjs=require("when")

errorCode = require '../../lib/error_code.coffee'
BaseRequest = require('./../BaseRequest.coffee').BaseRequest
BaseParam=require('../../logic/param/BaseQueryParam.coffee').BaseQueryParam

DayExcelRecordFactory = require('../../logic/dayExcelRecord/DayExcelRecordFactory.coffee').DayExcelRecordFactory

class GetExcelRecordListRequest extends BaseRequest

  constructor: (req, res, next)->
    super req, res, next
    params = req.body
    @params = new BaseParam(params.skip, params.max)

  _execute: ->
    request = this
    resultArray=[]
    DayExcelRecordFactory.getByParams(request.params)
    .then (items)->
      for item in items
        result={}
        result.id=item.getId()
        result.day=item.getDay()
        resultArray.push result
      return resultArray



exports.GetExcelRecordListRequest = GetExcelRecordListRequest


