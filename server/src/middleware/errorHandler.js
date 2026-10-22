const { fail, BizError } = require('../utils/response');

function notFound(req, res) {
  fail(res, 404, 404, '接口不存在');
}

// eslint-disable-next-line no-unused-vars
function errorHandler(err, req, res, next) {
  if (err instanceof BizError) {
    return fail(res, err.httpStatus, err.code, err.message);
  }
  if (err && err.code === 'LIMIT_FILE_SIZE') {
    return fail(res, 400, 1004, '参数校验失败：file 大小不能超过 5MB');
  }
  console.error('[error]', err);
  fail(res, 500, 500, '服务器内部错误');
}

module.exports = { notFound, errorHandler };
