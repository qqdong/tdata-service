memjs = require 'memjs'
whenjs = require 'when'

config = require '../config'

mcClient = memjs.Client.create(config.mc.locations, config.mc.options)

exports.get = (key) ->
  whenjs.promise (resolve, reject)->
    mcClient.get key, (err, value)->
      return reject err if err
      resolve value?.toString()

exports.set = (key, value, expires) ->
  whenjs.promise (resolve, reject)->
    mcClient.set key, value, (err, value)->
      return reject err if err
      resolve value
    , expires

exports.delete = (key) ->
  whenjs.promise (resolve, reject)->
    mcClient.delete key, (err, value)->
      return reject err if err
      resolve value
