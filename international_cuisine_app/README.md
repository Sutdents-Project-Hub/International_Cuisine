# International Cuisine Frontend (Flutter)

本目錄是 International Cuisine 的 Flutter 前端，支援 iOS / Android / 桌面與 Web。後端 API 預設使用 `http://localhost:3000`（Android 模擬器預設 `http://10.0.2.2:3000`）。

## 需求

- Flutter SDK（建議 stable）
- 後端 API（NestJS + Postgre），可用根目錄的 docker compose 一鍵啟動

## 快速開始（搭配根目錄 docker compose）

1. 在專案根目錄複製環境檔

```bash
cp .env.example .env
```

2. 啟動後端與資料庫

```bash
docker compose up -d
```

3. 啟動 Flutter（行動端/桌面）

```bash
flutter pub get
flutter run
```

## API Base URL 設定

`lib/core/api/api_config.dart` 支援 build-time 覆蓋：

- 通用

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:3000
```

- Android 模擬器（若後端跑在本機）

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000
```

未提供 `API_BASE_URL` 時，會依平台使用預設值。

## Flutter Web（本地或 Coolify）

### 本地跑 Web（非 Docker）

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:3000
```

### 用 Docker 建置並提供 Web（給 Coolify 用）

```bash
docker build -t cuisine-web --build-arg API_BASE_URL=https://your-api-domain.example .
docker run --rm -p 8080:80 cuisine-web
```

## api_client（OpenAPI 產生）

`packages/api_client` 是從後端 OpenAPI 規格產生的 Dart Dio Client。若後端 `swagger.json` 有更新，建議重新產生並同步到此 package（詳細流程請見根目錄或後端 README）。

## 上架（App Store / Play 商店）

### 共通

- 請使用 HTTPS 的 `API_BASE_URL` 進行上架版本建置
- App 的版本號來自 `pubspec.yaml` 的 `version: x.y.z+buildNumber`

### Android（Play 商店）

1. 建立上架 keystore（建議使用 Upload Key）
2. 在 `android/` 建立 `key.properties`（可參考 `android/key.properties.example`）
3. 產出 AAB

```bash
flutter build appbundle --release --dart-define=API_BASE_URL=https://your-api-domain.example
```

備註：`applicationId` 已設定為 `com.felix0901.internationalcuisine`。Play 商店第一次上架後不可再更改 package name。

### iOS（App Store）

1. 使用 Xcode 開啟 `ios/Runner.xcworkspace`
2. 設定 Signing（建議 Automatic Signing）與 Team
3. Archive 後透過 Organizer 上傳

若只想在 CI 驗證編譯（不簽名）：

```bash
flutter build ios --release --no-codesign --dart-define=API_BASE_URL=https://your-api-domain.example
```

備註：Bundle ID 已設定為 `com.felix0901.internationalcuisine`，且已移除 `NSAllowsArbitraryLoads`，只保留 `localhost` 的 HTTP 例外以利本機開發。
