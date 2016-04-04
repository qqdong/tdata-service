_ = require("underscore")
crypto = require("crypto")
fs = require("fs")
nodemailer = require("nodemailer")
config = require("../config")

exports.md5 = (str) ->
  crypto.createHash("md5").update(str, 'utf8').digest "hex"

exports.sortById = (objects, ids) ->
  idIndexMap = {}
  _(ids or []).each (id, index) ->
    idIndexMap[id] = index

  _(objects).sortBy (object) ->
    idIndexMap[object.id]


exports.sortByKeys = (objects, key, values) ->
  keyIndexMap = {}
  _(values or []).each (value, index) ->
    keyIndexMap[value] = index

  _(objects).sortBy (object) ->
    keyIndexMap[object[key]]


exports.sendMail = (option, callback) ->
  smtpTransport = nodemailer.createTransport(config.sendMail.smtp)
  mailOptions =
    from: config.sendMail.from
    to: option.to or config.sendMail.to
    subject: option.subject
    text: option.text
    html: option.html

  smtpTransport.sendMail mailOptions, (error, response) ->
    smtpTransport.close()
    callback error, response  if callback

exports.move = (source, des, callback) ->
  # fs.rename can not move a file from one partition to another
  is_ = fs.createReadStream(source)
  os = fs.createWriteStream(des)
  is_.pipe os
  is_.on "end", ->
    fs.unlinkSync source
    callback()

exports.getObjectValueStr = (source) ->
  getValueStr = (obj) ->
    return obj unless _.isArray(obj) or _.isObject(obj)
    Object.keys(obj).sort().reduce (pre, key) ->
      pre + getValueStr obj[key]
    ,''

  return getValueStr source

