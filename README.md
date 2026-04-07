# 燕语堂燕窝电商 · 部署指南

## 📁 文件说明

| 文件 | 说明 |
|------|------|
| `yanwo-shop.html` | 前台商城（客户购物页面） |
| `yanwo-admin.html` | 后台管理系统 |
| `config.js` | **🔑 配置文件（需要填写你的 Supabase 密钥）** |
| `vercel.json` | Vercel 路由配置 |
| `supabase-setup.sql` | 数据库初始化 SQL |

---

## 🚀 部署步骤（约 20 分钟）

### 第一步：注册账号

- **Supabase**：https://supabase.com（免费注册）
- **Vercel**：https://vercel.com（用 GitHub 账号登录）
- **GitHub**：https://github.com（如果还没有）

---

### 第二步：设置 Supabase 数据库

1. 登录 Supabase → 点击 **New Project**
2. 填写项目名称（如：yanyutang），选择离中国最近的区域（Singapore）
3. 等待项目创建完成（约1-2分钟）

**建立数据库表：**
1. 左侧菜单点击 **SQL Editor**
2. 点击 **New query**
3. 把 `supabase-setup.sql` 的全部内容粘贴进去
4. 点击 **Run**（右下角绿色按钮）

**创建图片存储：**
1. 左侧菜单点击 **Storage**
2. 点击 **New bucket**
3. 名称填写：`product-images`
4. 勾选 **Public bucket**
5. 点击 **Create bucket**

**获取 API 密钥：**
1. 左侧菜单点击 **Settings → API**
2. 复制 **Project URL**（格式：https://xxx.supabase.co）
3. 复制 **anon public** key（长串字符）

---

### 第三步：填写配置文件

打开 `config.js`，替换以下两行：

```js
const SUPABASE_URL = "https://你的项目ID.supabase.co";
const SUPABASE_ANON_KEY = "你的 anon public key";
```

---

### 第四步：上传到 GitHub

1. 登录 GitHub → 点击右上角 **+** → **New repository**
2. 仓库名填写：`yanyutang-shop`，设为 **Public**
3. 点击 **Create repository**
4. 把所有文件上传：点击 **uploading an existing file** → 把这5个文件全部拖进去 → 点击 **Commit changes**

---

### 第五步：部署到 Vercel

1. 登录 https://vercel.com
2. 点击 **Add New → Project**
3. 选择你刚创建的 GitHub 仓库 `yanyutang-shop`
4. 直接点击 **Deploy**（无需任何额外配置）
5. 等待约1分钟，部署完成！

---

## 🌐 访问地址

部署成功后，Vercel 会给你一个网址，例如：

| 页面 | 地址 |
|------|------|
| 前台商城 | `https://yanyutang-shop.vercel.app/` |
| 后台管理 | `https://yanyutang-shop.vercel.app/admin` |

**后台登录：**
- 账号：`admin`
- 密码：`admin123`（可在 yanwo-admin.html 中修改）

---

## 🔧 自定义域名（可选）

1. 在 Vercel 项目页面点击 **Settings → Domains**
2. 填写你的域名（如：shop.yourdomain.com）
3. 按提示在域名服务商处添加 DNS 记录
4. 等待5-30分钟生效，自动获得 HTTPS

---

## 💰 费用

完全免费，无需信用卡：

- **Vercel 免费版**：每月 100GB 流量
- **Supabase 免费版**：500MB 数据库 + 1GB 存储

月访问量超过10万再考虑升级付费计划。

---

## ❓ 常见问题

**Q：产品加载不出来？**  
A：检查 config.js 中的 SUPABASE_URL 和 SUPABASE_ANON_KEY 是否正确。

**Q：图片上传失败？**  
A：确认 Supabase Storage 中创建了名为 `product-images` 的 **Public** bucket。

**Q：如何修改管理员密码？**  
A：打开 `yanwo-admin.html`，找到 `doLogin()` 函数，修改 `admin123` 为你的新密码。

**Q：如何添加真实支付？**  
A：需要接入支付宝/微信开放平台 API，这需要企业营业执照。可以联系 Claude 帮你对接。
