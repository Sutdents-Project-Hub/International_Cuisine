# International Cuisine

International Cuisine 是一個前後端分離的美食探索與料理輔助專案：

- Frontend：Flutter（行動端 + 桌面 + Web）
- Backend：NestJS（REST API）
- Database：PostgreSQL
- API Client：由後端 OpenAPI 規格產生的 Dart Dio Client（位於前端 `packages/api_client`）

## 專案結構

- `international_cuisine_app/`：Flutter App 與 Flutter Web
- `international_cuisine_backend/`：NestJS + Prisma 後端
- `docker-compose.yml`：本地啟動 Backend + Postgre 的一鍵環境

## 本地快速啟動（Docker）

1. 複製環境檔

```bash
cp .env.example .env
```

2. 啟動後端與資料庫

```bash
docker compose up -d
```

3. 檢查後端狀態

- Health：`http://localhost:3000/api/v1/health`
- Swagger（非 production）：`http://localhost:3000/docs`

## 前端啟動（Flutter）

進入前端目錄：

```bash
cd international_cuisine_app
flutter pub get
flutter run
```

若需要指定 API Base URL（例如 Web 或不同環境），可使用：

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:3000
```

Android 模擬器連線到本機後端時常用：

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000
```

## 部署（Coolify）

建議在 Coolify 以「分開部署」方式維運：

### PostgreSQL

使用 Coolify 的 PostgreSQL 服務建立資料庫，並取得連線字串。

### Backend

- App 類型：Dockerfile
- Root / Directory：`international_cuisine_backend`
- 必要環境變數：
  - `DATABASE_URL`
  - `JWT_SECRET`
  - `NODE_ENV=production`
  - `CORS_ORIGINS`（逗號分隔，至少包含你的 Web 網域）

### Frontend Web

- App 類型：Dockerfile
- Root / Directory：`international_cuisine_app`
- Build args：
  - `API_BASE_URL=https://your-api-domain.example`

## 上架（App Store / Play 商店）

上架版本建議以 HTTPS API 為前提，並使用 `--dart-define=API_BASE_URL=...` 指向正式 API 網域。

### Android（Play 商店）

- Package name（applicationId）：`com.felix0901.internationalcuisine`
- Release signing：
  - 在 `international_cuisine_app/android/` 放置 `key.properties`（可參考 `key.properties.example`）
  - keystore 檔案請勿提交到 Git
- 產出 AAB：

```bash
cd international_cuisine_app
flutter build appbundle --release --dart-define=API_BASE_URL=https://your-api-domain.example
```

### iOS（App Store）

- Bundle ID：`com.felix0901.internationalcuisine`
- 建議用 Xcode 的 Automatic Signing + App Store Connect 上架流程
- CI 編譯驗證（不簽名）：

```bash
cd international_cuisine_app
flutter build ios --release --no-codesign --dart-define=API_BASE_URL=https://your-api-domain.example
```

## 注意事項

- 請勿提交 `.env` 或任何 secrets。本專案提供 `.env.example` 作為範例。
- Backend 在 `NODE_ENV=production` 會關閉 Swagger，並要求 `CORS_ORIGINS` 設定以避免過度放寬 CORS。
