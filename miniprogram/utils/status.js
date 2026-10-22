// 与 docs/03 数据字典一致的状态文案与颜色
const goodsStatus = {
  0: { text: '待审核', color: '#fa8c16' },
  1: { text: '已上架', color: '#07c160' },
  2: { text: '交换中', color: '#1989fa' },
  3: { text: '已换出', color: '#909399' },
  4: { text: '已下架', color: '#909399' },
  5: { text: '已驳回', color: '#ee0a24' },
};

const exchangeStatus = {
  0: { text: '待处理', color: '#fa8c16' },
  1: { text: '进行中', color: '#1989fa' },
  2: { text: '已拒绝', color: '#ee0a24' },
  3: { text: '已取消', color: '#909399' },
  4: { text: '已完成', color: '#07c160' },
};

const conditions = ['全新', '九成新', '八成新', '七成新及以下'];

module.exports = { goodsStatus, exchangeStatus, conditions };
