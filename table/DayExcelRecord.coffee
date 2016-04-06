Sequelize = require 'sequelize'
whenjs = require 'when'
cls = require('continuation-local-storage')

Table_Default_Config = require './table_default_config'
DB = require './tdata_sequelize.coffee'
Status = require('../logic/testdata/Status.coffee').Status
errorCode = require '../lib/error_code.coffee'

fields = {}

##基本信息#######################################

#自增长ID
fields.id =
  type: Sequelize.INTEGER 11
  autoIncrement: true
  primaryKey: true

#日期--天
fields.day =
  type: Sequelize.STRING 20
  allowNull: false


#文件名称
fields.file_name =
  type: Sequelize.STRING 50
  allowNull: false
  defaultValue: 0


options = Table_Default_Config.options
tableExcelRecord = DB.define 't_day_excels', fields, options
tableExcelRecord.sync()

##基本操作#######################################

findById = exports.findById = (id)->
  whenjs().then ()->
    tableExcelRecord.findOne
      where:
        id: id


#添加
exports.add = (day, fileName)->
  whenjs().then ()->
    tableExcelRecord.create
      day: day
      file_name: fileName


#获取列表
exports.findByParams = (params)->
  find_options = {}
  find_options.where = {}
  if params.max?
    find_options.limit = params.max
  if params.skip?
    find_options.offset = params.skip

  find_options.order = [
    ['created_at', 'DESC']
  ]

  whenjs().then ()->
    tableExcelRecord.findAll find_options
  .then (result)->
    return result

#获取数量
exports.getCountByParams = (params)->
  find_options = {}
  find_options.where = {}

  whenjs().then ()->
    tableExcelRecord.count find_options
  .then (count)->
    return count