express = require("express")
bodyParser = require("body-parser")
cookieParser = require("cookie-parser")
path = require("path")

middleware = require("../lib/middleware")
config = require("../config")

router = express.Router()
module.exports = exports = router

if config.blockIp
  router.use middleware.blockIp

router.get '/headers', (req, res) -> res.json req.headers

router.use bodyParser.urlencoded
  extended: false

router.use bodyParser.json()

router.use middleware.logger()

router.use middleware.allowCrossDomain

#路由配置
require("./init_sequelize.coffee")
require("../test/test_index.coffee")
require("../logic/job/job_index.coffee")

router.use "/testData",require("./testData.coffee")


router.use middleware.notFound
router.use middleware.error
