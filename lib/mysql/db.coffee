pools = require("./pools")

module.exports = exports = (name) ->
  pool = pools.getPool(name)

  return {
    query: () ->
      pool.query arguments...
    find: (sql, values, cb) ->
      pool.query sql, values, (err, rows, fields) ->
        return cb(err) if err
        return cb(null, rows)
    findOne: (sql, values, cb) ->
      pool.query sql, values, (err, rows, fields) ->
        return cb(err) if err
        return cb(null, null) if rows.length == 0
        return cb(null, rows[0])
  }
