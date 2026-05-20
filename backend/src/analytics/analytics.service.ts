import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateEventDto } from './dto/create-event.dto';
import { EventType, Prisma } from '@prisma/client';

@Injectable()
export class AnalyticsService {
  constructor(private readonly prisma: PrismaService) {}

  async trackEvent(userId: string | undefined, dto: CreateEventDto) {
    return this.prisma.analyticsEvent.create({
      data: {
        userId: userId || null,
        recipeId: dto.recipeId || null,
        eventType: dto.eventType,
        meta: dto.meta ? (dto.meta as Prisma.InputJsonValue) : undefined,
      },
    });
  }

  async getUserStats(userId: string) {
    const totalEvents = await this.prisma.analyticsEvent.count({
      where: { userId },
    });

    const eventsByType = await this.prisma.analyticsEvent.groupBy({
      by: ['eventType'],
      where: { userId },
      _count: { eventType: true },
    });

    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: {
        completedCount: true,
        level: true,
        xp: true,
        _count: {
          select: {
            favorites: true,
            shoppingLists: true,
            ratings: true,
          },
        },
      },
    });

    return {
      totalEvents,
      eventsByType: eventsByType.reduce(
        (acc: Record<EventType, number>, e) => {
          acc[e.eventType] = e._count.eventType;
          return acc;
        },
        {} as Record<EventType, number>,
      ),
      user,
    };
  }
}
