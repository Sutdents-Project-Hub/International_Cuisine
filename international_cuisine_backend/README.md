# International Cuisine Backend (NestJS + Prisma)

本目錄是 International Cuisine 的後端 API，使用 NestJS + Prisma，資料庫使用 PostgreSQL。預設 API 前綴為 `/api/v1`，Swagger（非 production）位於 `/docs`。

## 需求

- Node.js（建議 20+）
- PostgreSQL（或使用根目錄 docker compose）

## 環境變數

請參考 `.env.example`，常用項目如下：

- `DATABASE_URL`（必填）
- `JWT_SECRET`（必填）
- `NODE_ENV`（production 時會關閉 Swagger，並要求 `CORS_ORIGINS`）
- `CORS_ORIGINS`（production 必填，逗號分隔）
- `HOST`、`PORT`
- `RUN_SEED`（entrypoint 用；`true` 時會執行 `prisma db seed`）
- `SEED_ADMIN_EMAIL`、`SEED_ADMIN_USERNAME`、`SEED_ADMIN_PASSWORD`（有提供才建立/更新管理員）

## 本機開發（不用 Docker）

1. 安裝依賴

```bash
npm ci
```

2. 準備 `.env`

```bash
cp .env.example .env
```

3. Migration（需要 Postgre 已可連線）

```bash
npm run prisma:migrate:deploy
npm run prisma:seed
```

4. 啟動

```bash
npm run start:dev
```

## 用 Docker（建議使用根目錄 compose）

在專案根目錄：

```bash
cp .env.example .env
docker compose up -d
```

啟動後：

- API：`http://localhost:3000/api/v1`
- Health：`http://localhost:3000/api/v1/health`
- Swagger（非 production）：`http://localhost:3000/docs`

## Prisma Seed

Seed 腳本位於 `prisma/seed.js`：

- 若資料庫已存在 recipes/badges，seed 會跳過避免重複建立
- 只有在 `SEED_ADMIN_EMAIL`、`SEED_ADMIN_USERNAME`、`SEED_ADMIN_PASSWORD` 都有提供時，才會建立/更新管理員（role: ADMIN）

## 測試與品質

```bash
npm run build
npm test
```

## Coolify 部署建議（Backend）

建議在 Coolify：

1. 建立一個 PostgreSQL 服務（Coolify 管理）
2. 建立一個 Dockerfile App 指向本目錄（使用 `Dockerfile`）
3. 設定環境變數：
   - `DATABASE_URL` 指向 Coolify 的 Postgre
   - `JWT_SECRET` 使用長隨機字串
   - `NODE_ENV=production`
   - `CORS_ORIGINS` 設為你的 Web 網域（可多個，用逗號分隔）

