_ = require("underscore")
path = require("path")

stageConfig =
  development:
    port: 6301
    logDir: path.join(process.cwd(), "var/logs")
    useHttps: 0
    exportExcelPath:'/Users/qqdong/Documents/library/tdata-service/exportExcel'

  production:
    port: 6102
    logDir: "/data1/logs/tdata-node-service"
    useHttps: 0
    exportExcelPath:'/data1/files/tdata-service/exportExcel'

config =
  port: 80



env = process.env.NODE_ENV or "development"

module.exports = exports = _.extend(config, stageConfig[env])
exports.env = env
