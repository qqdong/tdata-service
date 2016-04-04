config = require '../config'

dbconfig =
  development:
    tdata:
      connectionLimit: 10,
      host:'localhost'
      user: 'root',
      password: '111111'
      database: 'tdata'
      charset: 'utf8mb4'
  production:
    tdata:
      connectionLimit: 20,
      host: '#',
      user: '#',
      password: '#'
      database: 'tdata'
      charset: 'utf8mb4'

module.exports = dbconfig[config.env]
