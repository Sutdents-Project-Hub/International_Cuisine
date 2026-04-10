# International Cuisine

International Cuisine 是一個前後端分離的美食探索與料理輔助專案，提供食譜瀏覽、收藏與評分、成就/解鎖機制、購物清單，以及後台內容管理與簡易分析等功能。

## 專案名稱

International Cuisine

## 專案簡介

- 前端：Flutter（行動端 + 桌面 + Web）
- 後端：NestJS（REST API，API 前綴 `/api/v1`）
- 資料庫：PostgreSQL
- API Client：由後端 OpenAPI 規格產生的 Dart Dio Client（位於前端 `international_cuisine_app/packages/api_client`）

## 功能列表

- 使用者：註冊/登入、個人資料
- 食譜：列表/搜尋/篩選、詳細頁、份量換算、完成/解鎖
- 社交：收藏（含分類）、評分與評論
- 遊戲化：等級、XP、成就徽章
- 購物清單：由食譜產生、合併食材、匯出 CSV
- 管理後台：食譜 CRUD、解鎖條件設定、使用者列表、簡易分析

## 技術架構

- 前端：Flutter + Dart（HTTP：Dio；狀態管理：Provider）
- 後端：NestJS + Prisma（驗證：class-validator；安全：helmet；Swagger 僅非 production）
- 資料庫：PostgreSQL
- 本地整合：`docker-compose.yml` 一鍵啟動 DB + Backend
- Web 部署：Flutter Web 建置後由 Nginx 提供靜態檔案（見 `international_cuisine_app/Dockerfile` 與 `nginx.conf`）

## 專案結構

```text
.
├─ international_cuisine_app/          # Flutter App / Flutter Web
├─ international_cuisine_backend/      # NestJS + Prisma 後端
├─ docker-compose.yml                  # 本地：PostgreSQL + Backend
└─ .env.example                        # 本地 compose 範例環境檔
```

## 本地測試教學

### 1) 一鍵啟動（Docker Compose）

```bash
cp .env.example .env
docker compose up -d
```

- Health：`http://localhost:3000/api/v1/health`
- Swagger（僅非 production）：`http://localhost:3000/docs`

### 2) 後端（lint / unit test）

```bash
cd international_cuisine_backend
npm ci
npm run lint
npm test
```

### 3) 前端（Flutter 測試）

```bash
cd international_cuisine_app
flutter pub get
flutter test
```

## 環境變數

### 根目錄（給 `docker-compose.yml` 使用）

請以 `.env.example` 為基準建立 `.env`：

- Postgres：`POSTGRES_USER`、`POSTGRES_PASSWORD`、`POSTGRES_DB`
- Backend：`JWT_SECRET`、`CORS_ORIGINS`
- Seed（啟動時自動灌資料）：`RUN_SEED`、`SEED_ADMIN_EMAIL`、`SEED_ADMIN_USERNAME`、`SEED_ADMIN_PASSWORD`

### 後端（本機不用 Docker）

後端目錄 `international_cuisine_backend/.env.example` 提供本機啟動用的範例：

- `DATABASE_URL`（必填）
- `JWT_SECRET`（必填）
- `NODE_ENV`（`production` 會關閉 Swagger）
- `CORS_ORIGINS`（逗號分隔；若未提供且非 production，後端會啟用寬鬆 CORS 以利開發）
- `HOST`、`PORT`

### 前端（Flutter）

前端不使用 `.env`，以 build-time 參數覆蓋 API：

- `API_BASE_URL`：用 `--dart-define=API_BASE_URL=...`（或 Flutter Web Docker build arg `API_BASE_URL`）

## Coolify 部署教學

建議採「分開部署」：

### PostgreSQL

- 使用 Coolify 的 PostgreSQL 服務建立資料庫
- 取得 `DATABASE_URL`（後端使用）

### Backend（NestJS）

- App 類型：Dockerfile
- Root / Directory：`international_cuisine_backend`
- Port：`3000`
- 必要環境變數：
  - `DATABASE_URL`
  - `JWT_SECRET`
  - `NODE_ENV=production`
  - `CORS_ORIGINS`（逗號分隔，至少包含你的 Web 網域）
- 可選環境變數：
  - `RUN_SEED=true` 時會在容器啟動時執行 `prisma db seed`
  - `SEED_ADMIN_EMAIL`、`SEED_ADMIN_USERNAME`、`SEED_ADMIN_PASSWORD`（三者皆提供才會建立/更新管理員）

### Frontend Web（Flutter Web）

- App 類型：Dockerfile
- Root / Directory：`international_cuisine_app`
- Build args：
  - `API_BASE_URL=https://your-api-domain.example`

## 前端 / 後端詳細文件連結

- 前端：[`international_cuisine_app/README.md`](international_cuisine_app/README.md)
- 後端：[`international_cuisine_backend/README.md`](international_cuisine_backend/README.md)
