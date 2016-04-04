#fs = require('fs')
#gm=require('gm')
imageSize=require 'image-size'
whenjs=require 'when'

exports.getSize= (filepath)->
  whenjs.promise (resolve,reject)->
    imageSize filepath, (err,size)->
      if (err)
        reject err
      else
        resolve
          width :size.width
          height:size.height