ErrorCode = require '../../lib/error_code.coffee'
BaseRequest = require('./../BaseRequest.coffee').BaseRequest

Param_ProductQueryParam = require('../../logic/param/product/ProductQueryParam.coffee').ProductQueryParam
Response_ProductList = require('../../response/product/ProductListResponse.coffee').ProductListResponse

ProductFactory = require('../../logic/product/ProductFactory.coffee').ProductFactory

class ProductListRequest extends BaseRequest

  constructor: (req, res, next)->
    super req, res, next
    params = req.body
    @params = new Param_ProductQueryParam(params.catalog_id, params.status, params.skip, params.max)

  _execute: ->
    request = this
    ProductFactory.getProductsByParams(request.params)
    .then (productList)->
      new Response_ProductList(productList).render()
    .then (res_result)->
      return res_result

exports.ProductListRequest = ProductListRequest


