whenjs=require("when")
moment=require("moment")

errorCode = require '../../lib/error_code.coffee'
BaseRequest = require('./../BaseRequest.coffee').BaseRequest


TestDataFactory = require('../../logic/testdata/TestDataFactory.coffee').TestDataFactory
TestDataModel=require('../../logic/testdata/TestData.coffee').TestData
TestDataStatus=require('../../logic/testdata/Status.coffee').Status
ExcelProcess = require('../../logic/testdata/ExcelProcess.coffee').ExcelProcess
TDataSequelize = require '../../table/tdata_sequelize.coffee'
Validator = require('../../util/Validator.coffee').Validator


class UpdateDataStatusRequest extends BaseRequest

  constructor: (req, res, next)->
    super req, res, next
    params = req.body
    @name = params.name
    @status=params.status
    @process_date=params.process_date
    @client_id=params.client_id
    throw  errorCode.commonError.parameterError unless not Validator.isNullOrEmpty(@name, @status, @process_date,@client_id)
    throw  errorCode.testDataError.statusError unless  parseInt(@status)==TestDataStatus.Status.Successed or parseInt(@status)==TestDataStatus.Status.Failed or parseInt(@status)==TestDataStatus.Status.Slow


  _execute: ->
    request = this
    TDataSequelize.transaction()
    .then (trans)->
      TestDataModel testDataModel=new TestDataModel()
      testDataModel.updateStatus(request.name,request.status,request.process_date,request.client_id)
      .then ()->
        trans.commit()
        return {}
      .catch (error)->
        trans.rollback()
        throw error


exports.UpdateDataStatusRequest = UpdateDataStatusRequest


