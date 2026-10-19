# 易易物（SwapVerse）

校内闲置物品交换微信小程序。学生把闲置物品发上来，写清想换什么，双方觉得合适就申请交换，同意后线下交换，不涉及支付与物流。

- 服务端：Node.js 18 + Express + MySQL 8.0，接口 32 个（V1.0）
- 小程序端：原生微信小程序，规划 11 个页面
- 文档：`docs/` 下 5 份设计文档（需求、接口、数据库、页面设计、前后端约定）

## 目录结构

```
.
├── docs/                 设计文档
│   ├── 01-需求文档.md
│   ├── 02-接口设计.md
│   ├── 03-数据库设计.md
│   ├── 04-页面设计说明.md
│   └── 05-前后端约定.md
├── miniprogram/          微信小程序端
│   ├── components/       公共组件（item-card）
│   ├── pages/            11 个页面（app.json 已注册）
│   └── utils/            请求封装（net.js）、状态对照（status.js）
└── server/               服务端
    ├── db/               建表脚本 schema.sql 与演示数据 seed.sql
    └── src/              启动入口、配置、中间件、连接池、统一返回
```

## 本地运行

```bash
# 1. 建库并导入表结构与演示数据（必须带字符集参数，否则含中文默认值会报 ERROR 1067）
mysql -u root -p --default-character-set=utf8mb4 < server/db/schema.sql
mysql -u root -p --default-character-set=utf8mb4 < server/db/seed.sql

# 2. 配置并启动服务端
cd server
cp .env.example .env      # 填写 DB_USER / DB_PASSWORD，保持 WX_MOCK=1
npm install
npm start                 # 监听 http://localhost:3000

# 3. 用微信开发者工具导入 miniprogram 目录
```

详细步骤与冒烟测试见 `运行说明.md`。演示账号：`user_a`、`user_b`（普通用户）、`admin_mock`（管理员，WX_MOCK 模式）。

## 成员与分工

| 成员 | 学号 | 负责内容 |
|---|---|---|
| 周晓明 | 241310132 | 需求文档、接口设计、服务端框架与登录/用户/分类/上传、后台管理 |
| 陈俊宇 | 241310210 | 数据库设计与建表脚本、前后端约定、物品/交换/留言/收藏模块与测试 |
| 周瑞 | 241310131 | 页面设计说明、小程序端框架与 11 个页面 |

## 提交约定

- 提交信息格式：`新增／修复／文档：说明`
- 每次提交只包含本人负责的文件，不代为提交他人代码
- 各人使用自己的 GitHub 账号与邮箱提交
- 按阶段提交：第 1 周框架与文档，第 2~3 周各自模块，第 4 周测试与文档
