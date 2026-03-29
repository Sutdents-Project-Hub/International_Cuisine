import {
  Injectable,
  ConflictException,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateFavoriteDto } from './dto/create-favorite.dto';
import { Prisma } from '@prisma/client';

@Injectable()
export class FavoritesService {
  constructor(private readonly prisma: PrismaService) {}

  async findAll(userId: string, categoryName?: string) {
    const where: Prisma.FavoriteWhereInput = { userId };
    if (categoryName) {
      where.categoryName = categoryName;
    }

    return this.prisma.favorite.findMany({
      where,
      include: {
        recipe: {
          select: {
            id: true,
            title: true,
            country: true,
            difficulty: true,
            totalTimeMinutes: true,
            caloriesPerServing: true,
            ratingAvg: true,
          },
        },
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async create(userId: string, dto: CreateFavoriteDto) {
    // Check if already favorited
    const existing = await this.prisma.favorite.findUnique({
      where: { userId_recipeId: { userId, recipeId: dto.recipeId } },
    });

    if (existing) {
      throw new ConflictException('Recipe already in favorites');
    }

    // Update recipe like count
    await this.prisma.recipe.update({
      where: { id: dto.recipeId },
      data: { likeCount: { increment: 1 } },
    });

    return this.prisma.favorite.create({
      data: {
        userId,
        recipeId: dto.recipeId,
        categoryName: dto.categoryName,
      },
    });
  }

  async remove(userId: string, id: string) {
    const favorite = await this.prisma.favorite.findFirst({
      where: { id, userId },
    });

    if (!favorite) {
      throw new NotFoundException('Favorite not found');
    }

    // Decrement recipe like count
    await this.prisma.recipe.update({
      where: { id: favorite.recipeId },
      data: { likeCount: { decrement: 1 } },
    });

    return this.prisma.favorite.delete({ where: { id } });
  }

  async getCategories(userId: string) {
    const favorites = await this.prisma.favorite.findMany({
      where: { userId, categoryName: { not: null } },
      select: { categoryName: true },
      distinct: ['categoryName'],
    });

    return favorites
      .map((f) => f.categoryName)
      .filter((v): v is string => typeof v === 'string' && v.length > 0);
  }
}
