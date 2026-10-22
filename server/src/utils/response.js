function ok(res, data = null) {
  res.json({ code: 0, message: 'ok', data });
}

function fail(res, httpStatus, code, message) {
  res.status(httpStatus).json({ code, message, data: null });
}

class BizError extends Error {
  constructor(httpStatus, code, message) {
    super(message);
    this.httpStatus = httpStatus;
    this.code = code;
  }
}

module.exports = { ok, fail, BizError };
