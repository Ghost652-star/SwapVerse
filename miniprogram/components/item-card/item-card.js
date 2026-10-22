const { baseUrl } = require('../../utils/net');

Component({
  properties: {
    goods: { type: Object, value: {} },
  },
  data: {
    base: '',
  },
  lifetimes: {
    attached() {
      this.setData({ base: baseUrl() });
    },
  },
  methods: {
    onTap() {
      const { goods } = this.data;
      if (!goods || !goods.id) return;
      wx.navigateTo({ url: `/pages/item/item?id=${goods.id}` });
    },
  },
});
