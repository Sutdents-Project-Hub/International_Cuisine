---
description: 建立 APP 後端 API (NestJS)，包含資料庫、Swagger 文件、安全防護、Swagger JSON 匯出，供 Flutter APP 使用
---

# APP Backend Skill

> 專門為 Flutter APP 打造的後端 API 服務，支持本地測試與 Coolify 部署。

## 核心流程

1. **解析需求**：AI 閱讀用戶提供的 APP 功能需求。
2. **初始化專案**：NestJS, Prisma, Swagger, JWT。
3. **基礎設施連線**：生成 `docker-compose.yaml` 並啟動本地 PostgreSQL。
4. **安全防護**：Throttler, Helmet, Swagger 生產環境保護。
5. **API 設計**：根據需求設計 RESTful API 與 資料庫 Schema。
6. **功能實作**：開發各個 Modules。
7. **本地測試**：啟動 Server 並測試 Swagger。
8. **匯出 Swagger JSON**：提醒用戶下載 JSON 給 Flutter 使用。

---

## 執行步驟

### 步驟一：專案初始化 (自動)

**注意**：如果用戶說「在當前目錄」，請使用 `.` 作為專案路徑。

```bash
npx -y @nestjs/cli new ./ --package-manager npm --strict

# 安裝依賴
npm install @nestjs/swagger swagger-ui-express @nestjs/passport passport passport-jwt @nestjs/jwt prisma @prisma/client class-validator class-transformer bcryptjs
npm install -D @types/passport-jwt @types/bcryptjs

# 安裝安全防護
npm install @nestjs/throttler helmet

npx prisma init

# 建立 docker-compose.yaml (PostgreSQL)
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
2. **JWT**：
   - `JWT_SECRET="dev-secret-change-in-production"`

**詢問並設定（若需要）：**

3. **檔案上傳**：
   - 詢問 S3/MinIO 資訊 (`S3_ENDPOINT`, `S3_ACCESS_KEY`...)
   - 安裝：`npm install @aws-sdk/client-s3` (建立 S3 Service)
4. **快取**：
   - 詢問 Redis URL (`REDIS_URL`)
   - 安裝：`npm install ioredis @nestjs/bull` (若需佇列)

### 步驟三：安全防護設定 (重要！)

在 `main.ts` 中設定以下安全措施：

```typescript
import { NestFactory } from '@nestjs/core';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import helmet from 'helmet';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // === 安全防護 ===
  app.use(helmet());
  app.enableCors();

  // === Swagger：僅在非生產環境啟用 ===
  if (process.env.NODE_ENV !== 'production') {
    const config = new DocumentBuilder()
      .setTitle('API 名稱')
      .setDescription('API 描述')
      .setVersion('1.0')
      .addBearerAuth()
      .build();

    const document = SwaggerModule.createDocument(app, config);
    SwaggerModule.setup('docs', app, document);
  }

  await app.listen(3000);
}
```

在 `app.module.ts` 中設定 Rate Limiting：

```typescript
import { ThrottlerModule, ThrottlerGuard } from '@nestjs/throttler';
import { APP_GUARD } from '@nestjs/core';

@Module({
  imports: [
    ThrottlerModule.forRoot([{
      ttl: 60000,   // 60 秒
      limit: 20,    // 最多 20 次請求
    }]),
    // ...其他 modules
  ],
  providers: [
    {
      provide: APP_GUARD,
      useClass: ThrottlerGuard,
    },
  ],
})
export class AppModule {}
```

> **Swagger URL**（本地開發時）：
> - UI：`http://localhost:3000/docs`
> - JSON：`http://localhost:3000/docs-json`（Flutter 需要這個）
>
> **正式環境**：Swagger 自動關閉，返回 404。

### 步驟四：API 與功能開發
1. 設計 `schema.prisma`
2. 建立 Auth Module (JWT，含過期時間設定)
3. 建立業務 Modules (包含 UploadController 若需上傳)
4. 每個 Controller 的方法都要加上 Swagger 裝飾器：
   - `@ApiTags()` - 分類
   - `@ApiOperation()` - 描述
   - `@ApiResponse()` - 回應格式
   - `@ApiBearerAuth()` - 需要登入的 API

### 步驟五：JWT 設定要點

```typescript
// auth.module.ts
JwtModule.register({
  secret: process.env.JWT_SECRET,
  signOptions: { expiresIn: '7d' }, // Token 7 天過期
}),
```

> JWT 必須設定過期時間，不可使用永久 Token。

### 步驟六：本地測試指引

> "API 開發完成！請執行以下指令進行測試：
>
> ```bash
> npm run start:dev
> ```
>
> 測試網址：
> - **Swagger 測試介面**：http://localhost:3000/docs
> - **Swagger JSON**（給 Flutter 用）：http://localhost:3000/docs-json
>
> 在 Swagger 中：
> 1. 先呼叫 `POST /auth/register` 註冊
> 2. 再呼叫 `POST /auth/login` 取得 Token
> 3. 點擊上方 'Authorize' 按鈕，輸入 `Bearer {token}`
> 4. 之後就可以測試需要登入的 API 了"

### 步驟七：匯出 Swagger JSON 給 Flutter

> "如果您需要在 Flutter APP 中使用這些 API，請執行以下指令匯出 JSON：
>
> ```bash
> curl http://localhost:3000/docs-json -o swagger.json
> ```
>
> 然後參考技術文件中的 [Flutter 整合教學] 來生成 Dart Client。
>
> 注意：每次 API 有修改時，都需要重新匯出並生成 Client。正式部署後 Swagger 會被關閉，所以請務必在本地完成匯出。"

### 步驟八：產生 README.md

初始化完成後，AI 必須自動產生 `README.md`，格式參考 `readme-master` Skill。

內容須包含：
- 專案名稱與簡介 (中英文)
- API 功能列表
- Tech Stack（含安全套件）
- 安裝與執行指令（含 Docker 資料庫啟動）
- 環境變數說明
- 資料庫結構說明
- Swagger 測試指引
- 匯出 Swagger JSON 的指令
- 安全性設定說明
- 部署指引

禁止使用 emoji。

---

## 給 AI 的提示

- 當用戶提到「Flutter」，主動提醒 Swagger JSON 匯出方式。
- 每個 API endpoint 都必須有完整的 Swagger 裝飾器。
- 在開發完成的訊息中，務必列出 Swagger UI 和 JSON 的網址。
- `.env` 中的 `DATABASE_URL` 在本地開發時使用 `localhost`，部署時會改成 Coolify Internal URL。
- **正式環境必須關閉 Swagger**：在 `main.ts` 加入 `NODE_ENV` 判斷。
- **必須安裝 `@nestjs/throttler` 和 `helmet`**：這是基本安全防護。
- **JWT 必須設定 `expiresIn`**：不可使用永久 Token。
