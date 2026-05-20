---
description: 產生或更新專案的 README.md 文件，包含中英文雙語說明
---

# README Master Skill

> 自動掃描專案結構，產生或更新專案的 README.md 文件。

## 功能

- 掃描 `package.json` 取得專案名稱與依賴
- 掃描 `prisma/schema.prisma` 取得資料庫結構
- 掃描 `.env.example` 或 `.env` 取得環境變數
- 產生中英文雙語的 README

---

## 執行步驟

### 步驟一：掃描專案

AI 檢查以下檔案：
- `package.json` (專案名稱、依賴)
- `prisma/schema.prisma` (資料庫結構)
- `.env.example` 或 `.env` (環境變數)
- `src/` 目錄結構 (功能模組)

### 步驟二：產生 README.md

使用以下範本格式 (禁止使用 emoji)：

```markdown
# 專案名稱 Project Name

> 專案簡介 / Brief description of the project

---

## 功能 Features

- 功能一的說明 / Description of feature 1
- 功能二的說明 / Description of feature 2

---

## 技術棧 Tech Stack

| 技術 | 說明 |
|-----|------|
| Next.js 14 | React 全端框架 |
| Tailwind CSS | 樣式框架 |
| PostgreSQL | 資料庫 |
| Prisma | ORM |

---

## 安裝與執行 Getting Started

### 安裝依賴 Install Dependencies

npm install

### 設定環境變數 Setup Environment

cp .env.example .env
# 填入您的環境變數

### 資料庫初始化 Database Setup

npx prisma db push

### 啟動開發伺服器 Start Development Server

npm run dev

---

## 環境變數 Environment Variables

| 變數名稱 | 說明 | 必填 |
|---------|------|-----|
| DATABASE_URL | PostgreSQL 連線字串 | 是 |
| NEXTAUTH_SECRET | 認證密鑰 | 是 |
| ... | ... | ... |

---

## 資料庫結構 Database Schema

### User (使用者)

| 欄位 | 類型 | 說明 |
|-----|------|-----|
| id | String | 唯一識別碼 |
| email | String | 電子郵件 |
| name | String | 使用者名稱 |
| ... | ... | ... |

### Product (商品)

| 欄位 | 類型 | 說明 |
|-----|------|-----|
| id | String | 唯一識別碼 |
| name | String | 商品名稱 |
| price | Int | 價格 |
| ... | ... | ... |

---

## 部署 Deployment

本專案使用 Coolify 進行部署。

1. 在 Coolify 建立新的 Application
2. 連接 GitHub Repository
3. 設定環境變數
4. 選擇 Dockerfile 作為 Build Pack
5. 部署

---

## 授權 License

MIT
```

---

## 給 AI 的提示

- 當用戶說「更新 README」或「產生文件」時，使用此 Skill
- 根據實際專案內容調整範本
- 資料庫結構說明需要包含每個欄位的中文用途
- 禁止使用任何 emoji
- 所有標題都要有中英文
