# 🍱 班級/團隊訂便當系統

點擊下方按鈕即可一鍵複製並部署至 Cloudflare Workers：

[![Deploy to Cloudflare Workers](https://deploy.workers.cloudflare.com/button)](https://deploy.workers.cloudflare.com/?url=https://github.com/jai4shao/bento)

### 💡 第一次使用設置步驟 (僅需 2 分鐘)：
1. 點擊上方按鈕，登入您的 **Cloudflare 帳號** 並按確認部署。
2. 進入 Cloudflare 後台：
   - 點擊左側 **Storage & Databases** ➔ **D1 SQL Database** ➔ 點擊 **Create Database**（名稱填寫 `bento_db`）。
   - 進入該資料庫的 **Console** 分頁，將專案中的 `schema.sql` 貼上並按下 **Execute** 完成建表。
3. 回到剛建立的 Worker ➔ **Settings** ➔ **Bindings**：
   - 點擊 **Add Binding** ➔ 選擇 **D1 Database**。
   - Variable name 填寫 `DB`，Database 選擇 `bento_db`。
4. 點擊 Worker 網址，即可開始使用！
