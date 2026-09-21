-- 1. 店家資料表 (SQLite 不支援 ENUM，改用 TEXT + CHECK)
CREATE TABLE IF NOT EXISTS stores (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  phone TEXT,
  address TEXT,
  is_active INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  category TEXT DEFAULT 'bento' CHECK(category IN ('bento', 'drink'))
);

-- 2. 菜單品項表
CREATE TABLE IF NOT EXISTS menu_items (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  store_id INTEGER NOT NULL,
  item_name TEXT NOT NULL,
  price INTEGER NOT NULL,
  is_available INTEGER DEFAULT 1,
  sort_order INTEGER DEFAULT 0,
  FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE
);

-- 3. 人員名冊
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  note TEXT,
  avatar_url TEXT DEFAULT ''
);

-- 4. 訂單紀錄表 (補上 paid_amount 方便對帳)
CREATE TABLE IF NOT EXISTS orders (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_name TEXT NOT NULL,
  item_id INTEGER,
  price INTEGER DEFAULT 0,
  paid_amount INTEGER DEFAULT 0,
  note TEXT DEFAULT '',
  ice TEXT DEFAULT '',
  sugar TEXT DEFAULT '',
  is_paid INTEGER DEFAULT 0,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (item_id) REFERENCES menu_items (id) ON DELETE SET NULL
);

-- 5. 系統設定
CREATE TABLE IF NOT EXISTS system_settings (
  setting_key TEXT PRIMARY KEY,
  setting_value TEXT NOT NULL,
  description TEXT
);

-- 寫入基礎系統設定 (API Key 請透過環境變數管理，不寫死明文)
INSERT OR IGNORE INTO system_settings (setting_key, setting_value, description) VALUES
('gemini_api_key', '', 'Google Gemini API 金鑰'),
('order_manual_lock', 'auto', '手動強制結單開關 (auto / force_open / force_lock)'),
('order_start_weekday', '1', '開放星期 (1: 週一)'),
('order_start_time', '06:00', '開放時間'),
('order_end_weekday', '5', '截止星期 (5: 週五)'),
('order_end_time', '12:30', '截止時間'),
('last_reset_week', '2026-38', '最後自動重設週期');
