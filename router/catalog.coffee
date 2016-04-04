express = require 'express'
router = express.Router()

Request_CatalogList=require('../request/catalog/CatalogListRequest.coffee').CatalogListRequest

#分类列表
router.post '/list', (req, res, next)->
  request = new Request_CatalogList req, res, next
  request.render()

module.exports = exports = router
