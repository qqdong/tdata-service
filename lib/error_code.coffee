#约定如下：

#1.公共错误码
#400 参数缺失或错误
#401 权限不允许
#404 页面未找到
#500 服务器内部错误

#2.业务错误码
#10000-10999 用户
#20000-20999 测试数据

#后续依次扩展，第一位超过9时，接着是11000，12000......12999,13000......99999


#==================================#
class error
  constructor: (@error_code, @error) ->


exports.commonError =
  parameterError: new error 400, '参数错误'
  noPermissions: new error 401, '没有权限操作'
  ipIsBlocked: new error 402, '此ip不能访问'
  notFond: new error 404, '请求资源不存在'
  internalError: new error 500, '服务器内部错误'
  catalogCacheUpdateFailedError: new error 601, '分类缓存更新失败'

exports.testDataError=
  nameNoExist:new error 20000,'name不存在'
  notEnoughData:new error 20001,'没有足够的测试数据'
  statusError:new error 20002,'数据状态不正确'
  excelFormatError:new error 20003,'Excel格式不正确'


#设置为不可修改
Object.freeze exports.commonError
