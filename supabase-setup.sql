-- ================================================
-- 燕语堂 · Supabase 数据库初始化脚本
-- 使用方法：登录 Supabase → SQL Editor → 粘贴运行
-- ================================================

-- 1. 产品表
create table if not exists products (
  id            serial primary key,
  name          text not null,
  category      text default 'classic',
  description   text,
  price         numeric(10,2) not null,
  original_price numeric(10,2),
  weight        text,
  stock         int default 0,
  badge         text,
  status        text default 'on',
  images        text[],
  sales         int default 0,
  created_at    timestamptz default now()
);

-- 2. 订单表
create table if not exists orders (
  id            text primary key,
  customer_name text,
  phone         text,
  address       text,
  items         jsonb,
  total         numeric(10,2),
  payment       text,
  status        text default 'pending',
  created_at    timestamptz default now()
);

-- 3. 允许前台匿名读取产品（上架中）
create policy "Public can view active products"
  on products for select
  using (status = 'on');

-- 4. 允许前台匿名新增订单
alter table orders enable row level security;
create policy "Anyone can insert orders"
  on orders for insert
  with check (true);

create policy "Anyone can read orders by id"
  on orders for select
  using (true);

-- 5. 开启 RLS 产品表
alter table products enable row level security;

-- 6. 插入示例产品数据
insert into products (name, category, description, price, original_price, weight, stock, badge, status, sales) values
  ('官燕皇级燕盏',  'classic', '马来西亚天然洞燕，唾液酸含量≥12%，极品滋补佳品', 1280, 1580, '50g',    98,  '热销', 'on', 156),
  ('清风即食燕窝',  'instant', '鲜炖即食，低糖配方，富含胶原蛋白与唾液酸',        388,  468,  '6瓶装',  234, '爆款', 'on', 312),
  ('礼装珍品套装',  'gift',    '精美礼盒，燕窝100g + 精华口服液，尊贵送礼首选',   2580, 3180, '100g+礼盒', 45, '礼品', 'on', 88),
  ('滋养燕窝精华',  'classic', '燕窝+花旗参+枸杞三重滋补，低温提炼活性更高',     698,  880,  '30粒',   167, '新品', 'on', 203),
  ('产后恢复套餐',  'gift',    '特别配制，适合产后妈妈调理身体，温和无刺激',      1680, 1980, '30天套餐', 62, '推荐', 'on', 134),
  ('官燕碎角实惠装','instant', '完整燕盏余下的精华碎角，营养等同，价格亲民',      480,  620,  '100g',   289, '超值', 'on', 445);

-- ================================================
-- Storage Bucket 设置（在 Supabase 控制台操作）：
-- 1. 进入 Storage 页面
-- 2. 点击 "New bucket"
-- 3. 名称填写：product-images
-- 4. 勾选 "Public bucket"（公开访问）
-- 5. 点击 Create
-- ================================================
