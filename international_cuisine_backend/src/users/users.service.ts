import { Injectable, ConflictException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { UpdateProfileDto } from './dto/update-profile.dto';

@Injectable()
export class UsersService {
  constructor(private readonly prisma: PrismaService) {}

  async updateProfile(userId: string, dto: UpdateProfileDto) {
    if (dto.username) {
      const existing = await this.prisma.user.findFirst({
        where: { username: dto.username, NOT: { id: userId } },
      });
      if (existing) {
        throw new ConflictException('Username already taken');
      }
    }

    return this.prisma.user.update({
      where: { id: userId },
      data: dto,
      select: {
        id: true,
        email: true,
        username: true,
        avatarUrl: true,
        location: true,
        dietaryPreferences: true,
        completedCount: true,
        level: true,
        xp: true,
        role: true,
        updatedAt: true,
      },
    });
  }

  async getAchievements(userId: string) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: {
        completedCount: true,
        level: true,
        xp: true,
        badges: {
          include: { badge: true },
          orderBy: { unlockedAt: 'desc' },
        },
        unlockedRecipes: {
          include: {
            recipe: {
              select: {
                id: true,
                title: true,
                country: true,
                difficulty: true,
              },
            },
          },
          orderBy: { unlockedAt: 'desc' },
        },
      },
    });

    return user;
  }

  async getLevelInfo(userId: string) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: {
        level: true,
        xp: true,
        completedCount: true,
      },
    });

    const xpForNextLevel = (user?.level ?? 1) * 100; // 100 XP per level
    const progress = user ? (user.xp % 100) / 100 : 0;

    return {
      ...user,
      xpForNextLevel,
      progress,
    };
  }
}
