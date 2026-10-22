require('dotenv').config();

module.exports = {
  port: Number(process.env.PORT) || 3000,
  db: {
    host: process.env.DB_HOST || '127.0.0.1',
    port: Number(process.env.DB_PORT) || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'yiyiwu',
  },
  jwtSecret: process.env.JWT_SECRET || 'dev_only_secret',
  jwtExpiresIn: '7d',
  wx: {
    appid: process.env.WX_APPID || '',
    secret: process.env.WX_SECRET || '',
    mock: process.env.WX_MOCK === '1',
  },
};
