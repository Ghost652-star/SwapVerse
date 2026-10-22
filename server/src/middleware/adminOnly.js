const { fail } = require('../utils/response');

module.exports = function adminOnly(req, res, next) {
  if (req.userRole !== 1) {
    return fail(res, 403, 1002, '无权操作该资源');
  }
  next();
};
