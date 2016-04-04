ErrorCode = require '../lib/error_code.coffee'
whenjs = require 'when'

class BaseRequest

  constructor: (req, @res, @next)->
    if not req? or not req.body?
      throw ErrorCode.commonError.parameterError

    #if not (req.get('Auth-Api-Key')?)
    #  throw ErrorCode.userError.apiKeyNotFond

  render: ->
    request = this
    whenjs().then ()->
      request._execute()
    .then (response)->
      request.res.json(response)
    , request.next

  _execute: ->
    throw "ERROR: please implement the execute function."

exports.BaseRequest = BaseRequest
