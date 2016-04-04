nodefn = require 'when/node'

pools = require "./pools"

connWrapper = (conn) ->
  query: () ->
    nodefn.lift(conn.query).apply conn, arguments

  beginTransaction: () ->
    nodefn.lift(conn.beginTransaction).apply conn

  commit: () ->
    nodefn.lift(conn.commit).apply conn

  rollback: () ->
    nodefn.lift(conn.rollback).apply conn

  release: () -> conn.release()


poolWrapper = (pool) ->
  query: () ->
    nodefn.lift(pool.query).apply pool, arguments

  find: (sql, values) ->
    @query sql, values
    .then ([rows]) ->
      return rows

  findOne: (sql, values) ->
    @find sql, values
    .then (rows) ->
      return rows?[0]

  getConnection: () ->
    nodefn.lift(pool.getConnection).apply pool

  transaction: (handler) ->
    @getConnection()
    .then (conn) ->
      connWrapper conn
    .then (conn) ->
      # conn is a wrapper with promise
      conn.beginTransaction()
      .then () ->
        handler conn
      .then () ->
        conn.commit()
      .catch (err) ->
        conn.rollback()
        throw err
      .finally () ->
        conn.release()

module.exports = exports = (name) ->
  poolWrapper pools.getPool name
