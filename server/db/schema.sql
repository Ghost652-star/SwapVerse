-- “易易物”数据库建表脚本
-- MySQL 8.0，字符集 utf8mb4，引擎 InnoDB
-- 依据：docs/03-详细设计说明书.md 第1节

CREATE DATABASE IF NOT EXISTS yiyiwu DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE yiyiwu;

-- 用户表
CREATE TABLE user (
  id             BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  openid         VARCHAR(64)  NOT NULL COMMENT '微信openid',
  nickname       VARCHAR(64)  NOT NULL DEFAULT '微信用户',
  avatar         VARCHAR(255) NOT NULL DEFAULT '',
  contact        VARCHAR(128) NOT NULL DEFAULT '' COMMENT '联系方式，交换达成后可见',
  campus         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '校区/宿舍楼',
  credit_done    INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '完成交换次数',
  credit_report  INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '被投诉次数',
  role           TINYINT NOT NULL DEFAULT 0 COMMENT '0 普通用户 1 管理员',
  status         TINYINT NOT NULL DEFAULT 0 COMMENT '0 正常 1 禁用',
  created_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_openid (openid)
) ENGINE=InnoDB COMMENT='用户';

-- 分类表
CREATE TABLE category (
  id    INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name  VARCHAR(32) NOT NULL,
  sort  INT NOT NULL DEFAULT 0 COMMENT '排序，越小越靠前',
  PRIMARY KEY (id)
) ENGINE=InnoDB COMMENT='物品分类';

-- 物品表
CREATE TABLE goods (
  id            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id       BIGINT UNSIGNED NOT NULL COMMENT '发布者',
  category_id   INT UNSIGNED NOT NULL,
  title         VARCHAR(64)  NOT NULL,
  `condition`   VARCHAR(16)  NOT NULL DEFAULT '' COMMENT '成色',
  expect        VARCHAR(128) NOT NULL DEFAULT '' COMMENT '期望换得的物品',
  description   TEXT,
  status        TINYINT NOT NULL DEFAULT 0 COMMENT '0待审核 1已上架 2交换中 3已换出 4已下架 5已驳回',
  reject_reason VARCHAR(255) NOT NULL DEFAULT '' COMMENT '驳回理由',
  created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_user (user_id),
  KEY idx_status_category (status, category_id),
  KEY idx_created (created_at)
) ENGINE=InnoDB COMMENT='物品';

-- 物品图片表
CREATE TABLE goods_image (
  id       BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  goods_id BIGINT UNSIGNED NOT NULL,
  url      VARCHAR(255) NOT NULL,
  sort     INT NOT NULL DEFAULT 0 COMMENT '图片顺序，0 为封面',
  PRIMARY KEY (id),
  KEY idx_goods (goods_id)
) ENGINE=InnoDB COMMENT='物品图片';

-- 留言表
CREATE TABLE message (
  id         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  goods_id   BIGINT UNSIGNED NOT NULL,
  user_id    BIGINT UNSIGNED NOT NULL,
  parent_id  BIGINT UNSIGNED DEFAULT NULL COMMENT '回复目标留言，可空',
  content    VARCHAR(500) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_goods (goods_id),
  KEY idx_user (user_id)
) ENGINE=InnoDB COMMENT='留言';

-- 收藏表
CREATE TABLE favorite (
  id         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id    BIGINT UNSIGNED NOT NULL,
  goods_id   BIGINT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_user_goods (user_id, goods_id)
) ENGINE=InnoDB COMMENT='收藏';

-- 交换表（申请与交换单合并，status 区分）
CREATE TABLE exchange (
  id                  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  applicant_id        BIGINT UNSIGNED NOT NULL COMMENT '申请方用户',
  target_goods_id     BIGINT UNSIGNED NOT NULL COMMENT '被申请的物品',
  offered_goods_id    BIGINT UNSIGNED NOT NULL COMMENT '申请方用于交换的物品',
  message             VARCHAR(255) NOT NULL DEFAULT '' COMMENT '申请留言',
  status              TINYINT NOT NULL DEFAULT 0 COMMENT '0待处理 1进行中 2已拒绝 3已取消 4已完成',
  applicant_confirmed TINYINT(1) NOT NULL DEFAULT 0 COMMENT '申请方已确认完成',
  owner_confirmed     TINYINT(1) NOT NULL DEFAULT 0 COMMENT '发布方已确认完成',
  created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  finished_at         DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  KEY idx_applicant (applicant_id),
  KEY idx_target_goods (target_goods_id),
  KEY idx_offered_goods (offered_goods_id),
  KEY idx_status (status)
) ENGINE=InnoDB COMMENT='交换申请/交换单';
