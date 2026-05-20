---
description: 協助準備 Coolify 部署所需的設定檔與環境變數，包含 Dockerfile、Prisma Migration、Internal URL 提醒
---

# Coolify Setup Skill

> 此 Skill 協助您準備部署到 Coolify 所需的所有設定，包含環境變數、Dockerfile 與部署檢查清單。

## 核心流程

1. **分析專案類型**：判斷是 Next.js 還是 NestJS。
2. **生成 Dockerfile**：如果不存在，自動建立（含 Prisma Migration）。
3. **生成環境變數**：整理所有需要的 ENV，提醒 Internal URL。
4. **提供部署指引**：一步步的操作說明。

---

## 執行步驟

### 步驟一：分析專案

AI 檢查當前專案，確認：
- 專案類型 (Next.js / NestJS / Payload CMS)
- 使用的服務 (PostgreSQL, Redis, MinIO)
- 需要的環境變數

### 步驟二：生成或檢查 Dockerfile

#### NestJS 專案

```dockerfile
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npx prisma generate
RUN npm run build

FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./
COPY --from=builder /app/prisma ./prisma
EXPOSE 3000
CMD npx prisma migrate deploy && node dist/main.js
```

> 注意：CMD 必須包含 `prisma migrate deploy`，這樣部署時會自動建立資料表。

#### Next.js 專案

```dockerfile
FROM node:20-alpine AS base

FROM base AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci

FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npx prisma generate
RUN npm run build

FROM base AS runner
WORKDIR /app
ENV NODE_ENV=production
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/prisma ./prisma
USER nextjs
EXPOSE 3000
CMD npx prisma migrate deploy && node server.js
```

> Next.js 必須在 `next.config.js` 加入 `output: 'standalone'`。

### 步驟三：生成環境變數

AI 務必產出完整的環境變數清單，並**明確提醒**以下重點：

```env
# ========================================
# 資料庫（最重要！請務必使用 Internal URL）
# ========================================
# 步驟：
# 1. 進入 Coolify Dashboard
# 2. 找到您的 PostgreSQL 資料庫
# 3. 複製 "Internal Connection String"
# 4. 貼到下面（取代整行）
#
# 正確範例：postgresql://postgres:密碼@my-db-service:5432/postgres
# 錯誤範例：postgresql://...@localhost:5432/...（這是本地用的！）
DATABASE_URL=<請貼上 Coolify 的 Internal Connection String>

# ========================================
# 認證 (NestJS)
# ========================================
JWT_SECRET=<請產生一個隨機密鑰，例如用 openssl rand -base64 32>
NODE_ENV=production

# ========================================
# 認證 (Next.js / NextAuth)
# ========================================
NEXTAUTH_URL=https://您的網域.com
NEXTAUTH_SECRET=<請產生一個隨機密鑰>

# ========================================
# 第三方服務 (視專案而定)
# ========================================
# Google 登入
GOOGLE_CLIENT_ID=xxx
GOOGLE_CLIENT_SECRET=xxx

# MinIO / S3 檔案上傳
S3_ENDPOINT=http://minio服務名稱:9000
S3_ACCESS_KEY=xxx
S3_SECRET_KEY=xxx
S3_BUCKET_NAME=uploads

# Redis 快取
REDIS_URL=redis://redis服務名稱:6379
```

### 步驟四：部署前檢查清單

AI 提醒用戶確認以下事項：

- [ ] `Dockerfile` 已存在於專案根目錄
- [ ] `Dockerfile` 的 CMD 包含 `prisma migrate deploy`
- [ ] `next.config.js` 已設定 `output: 'standalone'` (Next.js)
- [ ] 程式碼已 push 到 GitHub
- [ ] Coolify 上的 PostgreSQL 資料庫已建立且 Running
- [ ] 已複製 **Internal Connection String**
- [ ] Coolify Build Pack 選擇 `Dockerfile`
- [ ] Port 設定為 `3000`
- [ ] 所有環境變數已正確填入

### 步驟五：部署後驗證

- [ ] 網站/API 可正常存取
- [ ] 資料庫連線正常（可以註冊/登入）
- [ ] Prisma Migration 已自動執行（檢查 Deploy Log）
- [ ] 圖片上傳功能正常 (如果有)
- [ ] 寄信功能正常 (如果有)

---

## 給 AI 的提示

- 當用戶說「幫我部署」或「準備部署」時，使用此 Skill
- **最重要的提醒**：Internal Connection String，這是最常出錯的地方
- 優先檢查 `DATABASE_URL` 是否使用了內部服務名稱（不是 localhost 或外部 IP）
- Dockerfile 必須包含 `prisma migrate deploy`，否則正式資料庫不會有資料表
- 確保 `.env` 中的敏感資訊不會被 commit 到 Git（檢查 `.gitignore`）
- 如果用戶的專案使用 Prisma，提醒他們本地的 `docker-compose.yaml` 不需要部署到 Coolify
