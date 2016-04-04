Sequelize = require 'sequelize'
Config = require '../config/mysql'
logger = require('../lib/logger') __filename

#全局事务控制
cls = require('continuation-local-storage')
Sequelize.cls = cls.createNamespace('tdata')

tdata_sequelize = new Sequelize Config.tdata.database,
  Config.tdata.user,
  Config.tdata.password,
  host : Config.tdata.host
  dialect : 'mysql'
  dialectOptions :
    charset : Config.tdata.charset
  logging : ()->
    logger.debug arguments
  pool :
    maxConnections : 10
    minConnections : 2
  # the connect will be released after idled for 300 seconds
    maxIdleTime : 1000 * 600
  timezone : '+08:00'


module.exports = tdata_sequelize