Sequelize = require 'sequelize'
whenjs = require 'when'

Table_Default_Config = require './table_default_config'
DB = require './tdata_sequelize.coffee'
Status = require '../logic/testdata/Status.coffee'

fields = {}

##测试数据基本信息#######################################

#自增长ID
fields.id =
  type: Sequelize.INTEGER 11
  autoIncrement: true
  primaryKey: true

#测试数据unique
fields.name =
  type: Sequelize.STRING 100
  allowNull: false


#type
fields.type =
  type: Sequelize.INTEGER 2
  allowNull: false
  defaultValue: 0

#测试数据状态
fields.status =
  type: Sequelize.INTEGER 1
  allowNull: false
  defaultValue: 0
  comment: "测试数据状态：0新增，1处理中，2处理成功，3处理失败"

#上传时间
fields.upload_date =
  type: Sequelize.DATE
  allowNull: false
  default :new Date()

#处理时间
fields.process_date =
  type: Sequelize.DATE
  allowNull: true
  defaultValue: null

fields.is_download =
  type: Sequelize.INTEGER 1
  allowNull: false
  defaultValue: 0

options = Table_Default_Config.noTimeOptions
tableTestData = DB.define 't_testdata', fields, options
tableTestData.sync()

##测试数据基本操作#######################################

#批量添加
exports.bulkAdd = (params)->
  tableTestData.bulkCreate params

#获取下一条未处理数据
exports.findNextNewData = ()->
  find_options = {}
  find_options.where = {}
  find_options.where.status = Status.Status.New
  find_options.order = [
    ['id', 'ASC']
  ]

  whenjs().then ()->
    tableTestData.findOne find_options
  .then (result)->
    return result

#获取处理过的数据
exports.findProcessedData = (beginTime, endTime)->
  find_options = {}
  find_options.where = {}
  if beginTime? and endTime?
    find_options.where.process_date =
      $and:
        $gte: beginTime,
        $lt: endTime

  find_options.where.status =
    $in: [
      2,3
    ]

  find_options.order = [
    ['id', 'ASC']
  ]

  whenjs().then ()->
    tableTestData.findAll find_options
  .then (result)->
    return result