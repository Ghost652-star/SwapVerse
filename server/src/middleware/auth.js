const jwt = require('jsonwebtoken');
const config = require('../config');
const { fail } = require('../utils/response');

module.exports = function auth(req, res, next) {
  const header = req.headers.authorization || '';
  const token = header.startsWith('Bearer ') ? header.slice(7) : null;
  if (!token) {
    return fail(res, 401, 401, '未登录或登录已过期');
  }
  try {
    const payload = jwt.verify(token, config.jwtSecret);
    req.userId = payload.id;
    req.userRole = payload.role;
    next();
  } catch (err) {
    return fail(res, 401, 401, '未登录或登录已过期');
  }
};
