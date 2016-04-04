#测试数据状态
class Status
  constructor: ->

  @Status =
    New: 0 #新上传
    Processing: 1 #处理中
    Successed: 2 #处理成功
    Failed: 3 #处理失败

exports.Status=Status