# International Cuisine Frontend（Flutter）

## 模組簡介

本目錄為 International Cuisine 的 Flutter 前端，支援 iOS / Android / 桌面與 Web。預設連線後端 `http://localhost:3000`，可用 build-time 參數覆蓋。

## 使用技術

- Flutter / Dart
- HTTP：Dio
- 狀態管理：Provider
- API Client：OpenAPI 產生（`packages/api_client`）
- Web：Nginx（Docker image 提供靜態檔案）

## 資料夾結構

```text
international_cuisine_app/
├─ lib/                      # App 主程式
├─ assets/                   # 靜態資源
├─ packages/api_client/      # 後端 OpenAPI 產生的 Dart Client
├─ android/                  # Android 專案
├─ ios/                      # iOS 專案
├─ web/                      # Flutter Web 設定
├─ Dockerfile                # Flutter Web Docker build（給 Coolify）
└─ nginx.conf                # Nginx 設定（Web 部署）
```

## 本地開發流程

1. 啟動後端（建議用根目錄一鍵）

```bash
cp .env.example .env
docker compose up -d
```

2. 安裝依賴並啟動 App

```bash
cd international_cuisine_app
flutter pub get
flutter run
```

## 環境變數

前端不使用 `.env`，以 build-time 參數設定 API：

- `API_BASE_URL`：`--dart-define=API_BASE_URL=...`

預設值邏輯請見 `lib/core/api/api_config.dart`。

## 建置 / 啟動方式

### 行動端 / 桌面（開發）

```bash
flutter run
```

### 指定 API Base URL

- 通用（本機）

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:3000
```

- Android 模擬器（後端跑在同一台電腦）

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000
```

### Web（本地開發，非 Docker）

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:3000
```

### Web（Docker 建置與啟動）

```bash
docker build -t cuisine-web --build-arg API_BASE_URL=https://your-api-domain.example .
docker run --rm -p 8080:80 cuisine-web
```

## 部署細節

### Coolify（Flutter Web）

- App 類型：Dockerfile
- Root / Directory：`international_cuisine_app`
- Build args：
  - `API_BASE_URL=https://your-api-domain.example`

## 常見問題

### Android 模擬器連不到本機後端

- 將 `API_BASE_URL` 設為 `http://10.0.2.2:3000`

### Web 呼叫 API 被擋（CORS）

- 確認後端 `CORS_ORIGINS` 包含你的前端網域（多個以逗號分隔）
