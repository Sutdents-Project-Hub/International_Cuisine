# International Cuisine Backend（NestJS + Prisma）

## 模組簡介

本目錄為 International Cuisine 的後端 API，使用 NestJS + Prisma，資料庫為 PostgreSQL。

- API 前綴：`/api/v1`
- Health：`/api/v1/health`
- Swagger：僅在非 `NODE_ENV=production` 時提供 `GET /docs`

## 使用技術

- NestJS
- Prisma
- PostgreSQL
- Swagger（僅非 production）
- Helmet（安全性 HTTP header）

## 資料夾結構

```text
international_cuisine_backend/
├─ src/                # NestJS source code
├─ prisma/             # Prisma schema / migrations / seed
├─ docker/             # 容器啟動腳本（migrate/seed）
├─ Dockerfile          # Coolify/容器部署用
├─ package.json        # npm scripts
└─ .env.example        # 本機開發範例環境檔
```

## 本地開發流程

### 方式 A：用根目錄 Docker Compose（推薦）

在專案根目錄：

```bash
cp .env.example .env
docker compose up -d
```

啟動後：

- API：`http://localhost:3000/api/v1`
- Health：`http://localhost:3000/api/v1/health`
- Swagger（僅非 production）：`http://localhost:3000/docs`

### 方式 B：不用 Docker（本機 Node + 本機/遠端 Postgres）

1. 安裝依賴

```bash
npm ci
```

2. 準備環境檔

```bash
cp .env.example .env
```

3. Migration / Seed（需 `DATABASE_URL` 指向可連線的 Postgres）

```bash
npm run prisma:migrate:deploy
npm run prisma:seed
```

4. 啟動

```bash
npm run start:dev
```

## 環境變數

請參考 `.env.example`，常用項目如下：

- 必填：`DATABASE_URL`、`JWT_SECRET`
- 執行模式：`NODE_ENV`（`production` 會關閉 Swagger）
- CORS：`CORS_ORIGINS`（多個以逗號分隔；若未提供且非 production，後端會啟用寬鬆 CORS 以利開發）
- 監聽：`HOST`、`PORT`

## 建置 / 啟動方式

```bash
npm run build
npm run start:prod
```

## 部署細節

### Docker 行為

容器啟動時會：

- 若存在 migrations，執行 `prisma migrate deploy`；否則執行 `prisma db push`
- `RUN_SEED=true` 時執行 `prisma db seed`

### Coolify

- App 類型：Dockerfile
- Root / Directory：`international_cuisine_backend`
- Port：`3000`
- 必要環境變數：
  - `DATABASE_URL`
  - `JWT_SECRET`
  - `NODE_ENV=production`
  - `CORS_ORIGINS`（逗號分隔，至少包含你的 Web 網域）
- 可選環境變數：
  - `RUN_SEED=true`
  - `SEED_ADMIN_EMAIL`、`SEED_ADMIN_USERNAME`、`SEED_ADMIN_PASSWORD`（三者皆提供才會建立/更新管理員）

## 常見問題

### Swagger 看不到

- 確認 `NODE_ENV` 不是 `production`，Swagger 才會掛載在 `/docs`

### Web 呼叫 API 被擋（CORS）

- 設定 `CORS_ORIGINS`（多個以逗號分隔），並包含你的前端網域
