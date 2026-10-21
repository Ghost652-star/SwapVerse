-- “易易物”演示数据
-- 依据：docs/03-详细设计说明书.md 第4节
-- 前置：已执行 server/db/schema.sql

USE yiyiwu;

-- 分类（8 个）
INSERT INTO category (id, name, sort) VALUES
  (1, '教材书籍', 1),
  (2, '数码电子', 2),
  (3, '生活用品', 3),
  (4, '运动器材', 4),
  (5, '衣物服饰', 5),
  (6, '美妆护肤', 6),
  (7, '零食饮品', 7),
  (8, '其他', 8);

-- 用户：1 个管理员 + 2 个普通用户（openid 配合 WX_MOCK=1 直接登录）
INSERT INTO user (id, openid, nickname, avatar, campus, role) VALUES
  (1, 'admin_mock', '管理员', '', '东区', 1),
  (2, 'user_a', '同学甲', '', '东区3栋', 0),
  (3, 'user_b', '同学乙', '', '西区7栋', 0);

-- 样例物品：6 件已上架，挂在 user_a/user_b 名下，覆盖分类 1（教材书籍）与 2（数码电子）
INSERT INTO goods (id, user_id, category_id, title, `condition`, expect, description, status) VALUES
  (1, 2, 1, '高等数学同济第七版上下册', '八成新', '想换线性代数或概率论教材', '笔记不多，无缺页，上下册一起换。', 1),
  (2, 2, 2, '罗技 K380 蓝牙键盘', '九成新', '想换一个电脑支架', '功能正常，多设备切换，送电池。', 1),
  (3, 2, 1, '大学英语四级真题集', '全新', '想换六级真题', '买错了级别，塑封未拆。', 1),
  (4, 3, 2, '小米手环 7', '八成新', '想换一副蓝牙耳机', '续航正常，表带有一点使用痕迹。', 1),
  (5, 3, 1, 'C 程序设计（谭浩强）', '七成新', '想换数据结构教材', '有勾画但不影响阅读。', 1),
  (6, 3, 2, '绿联 USB-C 扩展坞', '九成新', '想换机械键盘', '接口齐全，箱说全。', 1);

INSERT INTO goods_image (goods_id, url, sort) VALUES
  (1, '/uploads/sample1.jpg', 0),
  (2, '/uploads/sample2.jpg', 0),
  (3, '/uploads/sample3.jpg', 0),
  (4, '/uploads/sample4.jpg', 0),
  (5, '/uploads/sample5.jpg', 0),
  (6, '/uploads/sample6.jpg', 0);
