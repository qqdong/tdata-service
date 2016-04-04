{BaseResponse} = require './../BaseResponse.coffee'
whenjs = require 'when'

class CatalogListResponse extends BaseResponse

  constructor: (catalogList)->
    @catalogList = catalogList
    @resultList = []

  getResult: ->
    return @resultList

  render: ->
    response = this
    whenjs.map response.catalogList, (catalog, index)->
      resultCatalog = {}
      resultCatalog.catalog_id = catalog.getId()
      resultCatalog.name = catalog.getName()
      response.resultList[index] = resultCatalog
    .then ()->
      return response.resultList

exports.CatalogListResponse = CatalogListResponse
