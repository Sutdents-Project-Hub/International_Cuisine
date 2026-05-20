import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { ThrottlerModule, ThrottlerGuard } from '@nestjs/throttler';
import { APP_GUARD } from '@nestjs/core';
import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { RecipesModule } from './recipes/recipes.module';
import { FavoritesModule } from './favorites/favorites.module';
import { ShoppingListsModule } from './shopping-lists/shopping-lists.module';
import { RatingsModule } from './ratings/ratings.module';
import { AnalyticsModule } from './analytics/analytics.module';
import { AdminModule } from './admin/admin.module';
import { HealthModule } from './health/health.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      validate: (config: Record<string, unknown>) => {
        const getEnvString = (key: string): string => {
          const value = config[key];
          return typeof value === 'string' ? value.trim() : '';
        };

        const databaseUrl = getEnvString('DATABASE_URL');
        const jwtSecret = getEnvString('JWT_SECRET');
        const nodeEnv = getEnvString('NODE_ENV') || 'development';
        const corsOrigins = getEnvString('CORS_ORIGINS');

        if (!databaseUrl) throw new Error('DATABASE_URL is required');
        if (!jwtSecret) throw new Error('JWT_SECRET is required');
        if (nodeEnv === 'production' && !corsOrigins) {
          throw new Error('CORS_ORIGINS is required in production');
        }

        return config;
      },
    }),
    ThrottlerModule.forRoot([
      {
        ttl: 60000, // 60 seconds
        limit: 20, // max 20 requests per minute
      },
    ]),
    PrismaModule,
    AuthModule,
    UsersModule,
    RecipesModule,
    FavoritesModule,
    ShoppingListsModule,
    RatingsModule,
    AnalyticsModule,
    AdminModule,
    HealthModule,
  ],
  providers: [
    {
      provide: APP_GUARD,
      useClass: ThrottlerGuard,
    },
  ],
})
export class AppModule {}
