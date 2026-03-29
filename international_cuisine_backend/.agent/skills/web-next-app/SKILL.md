---
description: 建立完整的 Next.js 全端網站，包含資料庫、API、認證、CMS 後台與前後端頁面
---

# Web Next App Skill

> 這是建立 Next.js 網站的通用 Skill，核心流程為「初始化 -> 連線資料庫 -> 開發 -> 本地測試 -> 部署」。

## 核心流程

1. **解析需求**：AI 閱讀用戶提供的完整需求文檔。
2. **判斷是否需要 CMS**：若需求包含「後台管理、上架商品、發布消息、員工帳號」，則整合 Payload CMS。
3. **初始化專案**：設定 Next.js, Tailwind, Prisma, NextAuth (或 Payload Auth)。
4. **基礎設施連線**：生成 `docker-compose.yaml` 並啟動本地 PostgreSQL。
5. **資料庫設計**：根據需求設計 Schema。
6. **功能開發**：使用 Server Actions 或 Payload Collections。
7. **前端開發**：(選用) 調用 `ui-ux-pro-max` Skill。
8. **本地測試**：確保能在 localhost 跑起來測試。

---

## CMS 判斷邏輯

若需求包含以下關鍵字，則自動整合 Payload CMS：
- 後台管理
- 上架商品 / 商品管理
- 發布消息 / 最新消息
- 員工帳號 / 多用戶管理
- CMS

---

## 執行步驟

### 步驟一：專案初始化

**注意**：如果用戶說「在當前目錄」，請使用 `.` 作為專案路徑。

#### 一般專案 (無 CMS)

```bash
npx -y create-next-app@latest ./ \
  --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm

npm install prisma @prisma/client next-auth@beta @auth/prisma-adapter zod react-hook-form lucide-react clsx tailwind-merge framer-motion bcryptjs

npx prisma init
```

#### 需要 CMS 的專案 (Payload CMS)

```bash
npx -y create-payload-app@latest ./ -t blank --db postgres

npm install lucide-react clsx tailwind-merge framer-motion
```

Payload 會自動設定好：
- Next.js + TypeScript
- 資料庫連線 (Postgres)
- Admin 後台 (/admin)
- 用戶認證系統

# 為兩種專案路徑建立 docker-compose.yaml (PostgreSQL)
cat <<EOF > docker-compose.yaml
version: '3.8'
services:
  postgres:
    image: postgres:15-alpine
    container_name: local_postgres
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
volumes:
  postgres_data:
EOF

# 啟動資料庫
docker-compose up -d
```

### 步驟二：設定本地開發環境 (.env)

**自動設定（無需詢問）：**

1. **資料庫**：設定為本地 Docker 連線
   - `DATABASE_URL="postgresql://user:password@localhost:5432/mydb?schema=public"`

2. **選配 - 檔案上傳 (MinIO/S3)**：
   如果需求包含「上傳圖片」，詢問 S3 資訊並安裝 `@aws-sdk/client-s3`。

3. **選配 - Email (Resend)**：
   如果需求包含「寄信、忘記密碼」，詢問 API Key 並安裝 `resend`。

### 步驟三：資料庫設計

#### 一般專案
更新 `prisma/schema.prisma`，包含 User, Account, Session 與業務 Model。

#### Payload CMS 專案
在 `src/collections/` 建立 Collections，例如：
- `Users.ts` (員工帳號)
- `Products.ts` (商品)
- `Posts.ts` (最新消息)
- `Members.ts` (會員)

### 步驟四：功能開發

#### 一般專案
使用 Server Actions (`src/actions/*.ts`)。

#### Payload CMS 專案
Payload 會自動產生 CRUD API，前端直接調用即可。

### 步驟五：本地測試指引

> "專案開發完成！請執行 `npm run dev`，然後：
> - 前台：http://localhost:3000
> - 後台 (CMS)：http://localhost:3000/admin
> 
> 第一次進入 /admin 時，請設定您的管理員帳號密碼。"

### 步驟六：產生 README.md

初始化完成後，AI 必須自動產生 `README.md`，格式參考 `readme-master` Skill。

內容須包含：
- 專案名稱與簡介 (中英文)
- 功能列表
- Tech Stack
- 安裝與執行指令
- 環境變數說明
- 資料庫結構說明 (若使用 Prisma)
- 部署指引

禁止使用 emoji。
