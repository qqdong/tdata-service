ErrorCode = require '../../lib/error_code.coffee'
BaseRequest = require('./../BaseRequest.coffee').BaseRequest

Param_BaseQuery = require('../../logic/param/BaseQueryParam.coffee').BaseQueryParam
Response_CatalogList = require('../../response/catalog/CatalogListResponse.coffee').CatalogListResponse

CatalogFactory = require('../../logic/catalog/CatalogFactory.coffee').CatalogFactory

class CatalogListRequest extends BaseRequest

  constructor: (req, res, next)->
    super req, res, next
    params = req.body
    @params = new Param_BaseQuery(params.skip, params.max)

  _execute: ->
    request = this

    CatalogFactory.getCatalogsByParams(request.params)
    .then (catalogList)->
      new Response_CatalogList(catalogList).render()
    .then (res_result)->
      return res_result

exports.CatalogListRequest = CatalogListRequest


