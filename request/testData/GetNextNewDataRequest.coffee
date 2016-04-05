whenjs=require("when")

errorCode = require '../../lib/error_code.coffee'
BaseRequest = require('./../BaseRequest.coffee').BaseRequest


TestDataFactory = require('../../logic/testdata/TestDataFactory.coffee').TestDataFactory
TestDataModel=require('../../logic/testdata/TestData.coffee').TestData
TestDataStatus=require('../../logic/testdata/Status.coffee').Status
ExcelProcess = require('../../logic/testdata/ExcelProcess.coffee').ExcelProcess
TDataSequelize = require '../../table/tdata_sequelize.coffee'

class GetNextNewDataRequest extends BaseRequest

  constructor: (req, res, next)->
    super req, res, next
    params = req.body
    @params = params

  _execute: ->
    request = this
    TDataSequelize.transaction()
    .then (trans)->
      TestDataFactory.getNextNewData()
      .then (testDataModel)->
        if not testDataModel?
          throw errorCode.testDataError.notEnoughData
        #更改状态为处理中
        testDataModel.updateStatus(testDataModel.getName(),TestDataStatus.Status.Processing)
        .then ()->
          trans.commit()
          return {name:testDataModel.getName()}
      .catch (error)->
        trans.rollback()
        throw error


exports.GetNextNewDataRequest = GetNextNewDataRequest


