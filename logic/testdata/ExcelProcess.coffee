whenjs = require('when')
excelParser = require('excel-parser')
excelExport=require('excel-export')
fs = require('fs')

class ExcelProcess
  constructor: ()->

  @parse: (filePath)->
    whenjs.promise (resolve, reject)->
      excelParser.parse
        inFile: filePath,
        worksheet: 1,
        skipEmpty: true
      , (err, records)->
        if err
          console.log  "excel parse error："+err
          reject err
        else
          resolve records
    .then (records)->
      console.log "excel parse success：" + filePath
      return records

  @save:(filePath,rows)->
    whenjs.promise (resolve, reject)->
      conf={}
      conf.name="testdata"
      conf.cols = [
        {caption:'name', type:'string', width:40},
        {caption:'type', type:'number', width:40},
        {caption:'status', type:'number', width:20},
        {caption:'uploadDate', type:'string', width:100},
        {caption:'processDate', type:'string', width:100},
        {caption:'clientId', type:'string', width:100}
      ]
      conf.rows =rows

      result = excelExport.execute(conf)

      fs.writeFile filePath, result, 'binary',(err)->
        if err
          console.log  "excel export error："+err
          reject err
        else
          resolve null
    .then ()->
      console.log ("excel export success :" + filePath)


exports.ExcelProcess = ExcelProcess