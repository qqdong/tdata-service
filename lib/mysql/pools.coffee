_ = require 'underscore'
mysql = require 'mysql'

mysqlConfig = require '../../config/mysql'
logger = require('../logger') __filename

poolMap = {}

exports.getPool = (name) ->
  if not poolMap[name]
    throw Error("can't find mysql pool #{name}") unless mysqlConfig[name]

    poolconfig = _.chain(mysqlConfig[name]).clone().extend
      queryFormat: (query, values) ->
        return query unless values

        query = query

        .replace /\?(\w+)\[(.+?)\]/g, (txt, key, str) =>
          if values.hasOwnProperty(key) && values[key] != undefined
            str
          else
            ''

        .replace /\:(\w+)/g, (txt, key) =>
          # 之后用 '=':'='key，防止被注入
          "'=':'='#{key}"

        .replace /@(\w+)/g, (txt, key) =>
          
          if values.hasOwnProperty(key)
            array = values[key]
            throw Error('@key must be array') unless _.isArray(array)

            (@escape(value) for value in array).join(',')
          else
            txt

        .replace /'='\:'='(\w+)/g, (txt, key) =>
          if values.hasOwnProperty(key)
            @escape(values[key])
          else
            ":#{key}"

        logger.debug query
        return query
    .value()

    pool = mysql.createPool poolconfig

    pool.on 'connection', (connection) ->
      logger.info 'new connection'

    pool.on 'enqueue', () ->
      logger.info 'Waiting for available connection slot'

    poolMap[name] = pool

  return poolMap[name]

exports.end = () ->
  for name, pool of poolMap
    pool.end()
