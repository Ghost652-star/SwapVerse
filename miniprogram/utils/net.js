const FALLBACK_BASE_URL = 'http://localhost:3000';

function baseUrl() {
  const app = getApp();
  return (app && app.globalData.baseUrl) || FALLBACK_BASE_URL;
}

function handle401(reject) {
  wx.removeStorageSync('token');
  wx.removeStorageSync('userInfo');
  const app = getApp();
  if (app) {
    app.globalData.token = '';
    app.globalData.userInfo = null;
  }
  wx.showToast({ title: '登录已过期，请重新登录', icon: 'none' });
  wx.navigateTo({ url: '/pages/auth/auth' });
  reject({ code: 401, message: '未登录' });
}

// 统一封装 wx.request：自动带 token，解包 {code,message,data}
function request(options) {
  return new Promise((resolve, reject) => {
    const token = wx.getStorageSync('token');
    wx.request({
      url: baseUrl() + options.url,
      method: options.method || 'GET',
      data: options.data,
      header: {
        'content-type': 'application/json',
        ...(token ? { Authorization: `Bearer ${token}` } : {}),
      },
      success(res) {
        if (res.statusCode === 401) {
          handle401(reject);
          return;
        }
        const body = res.data || {};
        if (body.code === 0) {
          resolve(body.data);
          return;
        }
        wx.showToast({ title: body.message || '请求失败', icon: 'none' });
        reject(body);
      },
      fail() {
        wx.showToast({ title: '网络异常，请确认服务端已启动', icon: 'none' });
        reject(new Error('network error'));
      },
    });
  });
}

// 图片上传（multipart）
function uploadFile(filePath) {
  return new Promise((resolve, reject) => {
    const token = wx.getStorageSync('token');
    wx.uploadFile({
      url: `${baseUrl()}/api/upload`,
      filePath,
      name: 'file',
      header: token ? { Authorization: `Bearer ${token}` } : {},
      success(res) {
        let body = {};
        try {
          body = JSON.parse(res.data);
        } catch (e) {
          wx.showToast({ title: '上传失败', icon: 'none' });
          reject(e);
          return;
        }
        if (res.statusCode === 401) {
          handle401(reject);
          return;
        }
        if (body.code === 0) {
          resolve(body.data);
          return;
        }
        wx.showToast({ title: body.message || '上传失败', icon: 'none' });
        reject(body);
      },
      fail() {
        wx.showToast({ title: '网络异常，请确认服务端已启动', icon: 'none' });
        reject(new Error('network error'));
      },
    });
  });
}

// 需要登录的操作入口守卫
function ensureLogin() {
  if (wx.getStorageSync('token')) return true;
  wx.showToast({ title: '请先登录', icon: 'none' });
  wx.navigateTo({ url: '/pages/auth/auth' });
  return false;
}

module.exports = { request, uploadFile, ensureLogin, baseUrl };
