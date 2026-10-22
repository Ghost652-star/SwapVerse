App({
  globalData: {
    baseUrl: 'http://localhost:3000',
    token: '',
    userInfo: null,
  },
  onLaunch() {
    this.globalData.token = wx.getStorageSync('token') || '';
    this.globalData.userInfo = wx.getStorageSync('userInfo') || null;
  },
});
