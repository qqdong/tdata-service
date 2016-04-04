{BaseResponse} = require './../BaseResponse.coffee'
whenjs = require 'when'

class ProductListResponse extends BaseResponse

  constructor: (productList)->
    @productList = productList
    @resultList = []

  getResult: ->
    return @resultList

  render: ->
    response = this
    whenjs.map response.productList, (product, index)->
      resultProduct = {}
      resultProduct.product_id = product.getId()
      resultProduct.title = product.getTitle()
      resultProduct.head_img=product.getHeadImg()
      resultProduct.price=product.getPrice()
      resultProduct.price_message=product.getPriceMessage()
      resultProduct.source_page_url=product.getSourcePageUrl()
      response.resultList[index] = resultProduct
    .then ()->
      return response.resultList

exports.ProductListResponse = ProductListResponse
