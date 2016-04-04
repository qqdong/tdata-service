express = require 'express'
router = express.Router()

module.exports = exports = router

Request_ProductList = require('../request/product/ProductListRequest.coffee').ProductListRequest

#产品列表
router.post '/list', (req, res, next)->
  request = new Request_ProductList req, res, next
  request.render()