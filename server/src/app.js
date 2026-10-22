const express = require('express');
const cors = require('cors');
const config = require('./config');
const pool = require('./dao/pool');
const { notFound, errorHandler } = require('./middleware/errorHandler');

const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/users');
const categoryRoutes = require('./routes/categories');
const goodsRoutes = require('./routes/goods');
const exchangeRoutes = require('./routes/exchanges');
const messageRoutes = require('./routes/messages');
const favoriteRoutes = require('./routes/favorites');
const adminRoutes = require('./routes/admin');
const uploadRoutes = require('./routes/upload');

const app = express();

app.use(cors());
app.use(express.json());
app.use('/uploads', express.static(require('path').join(__dirname, '..', 'uploads')));

app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/categories', categoryRoutes);
app.use('/api/goods', goodsRoutes);
app.use('/api/goods', messageRoutes);
app.use('/api/goods', favoriteRoutes);
app.use('/api/messages', messageRoutes);
app.use('/api/favorites', favoriteRoutes);
app.use('/api/exchanges', exchangeRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/upload', uploadRoutes);

app.use(notFound);
app.use(errorHandler);

app.listen(config.port, () => {
  console.log(`yiyiwu server listening on http://localhost:${config.port}`);
  if (config.wx.mock) {
    console.log('WX_MOCK=1：登录跳过微信 code2session，code 即 openid');
  }
  pool
    .query('SELECT 1')
    .then(() => console.log('MySQL 连接成功'))
    .catch((err) => console.error('MySQL 连接失败（HTTP 服务已启动，请检查 .env 数据库配置）:', err.message));
});
