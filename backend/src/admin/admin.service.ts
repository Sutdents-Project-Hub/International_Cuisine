import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateRecipeDto, UpdateRecipeDto } from './dto/admin-recipe.dto';
import { IngredientCategory, Prisma, ScaleStrategy } from '@prisma/client';

@Injectable()
export class AdminService {
  constructor(private readonly prisma: PrismaService) {}

  async createRecipe(authorId: string, dto: CreateRecipeDto) {
    return this.prisma.recipe.create({
      data: {
        title: dto.title,
        altTitles: dto.altTitles || [],
        country: dto.country,
        region: dto.region,
        city: dto.city,
        cuisineTags: dto.cuisineTags || [],
        isHidden: dto.isHidden || false,
        prepTimeMinutes: dto.prepTimeMinutes,
        cookTimeMinutes: dto.cookTimeMinutes,
        totalTimeMinutes: dto.totalTimeMinutes,
        difficulty: dto.difficulty,
        servingsBase: dto.servingsBase || 1,
        caloriesPerServing: dto.caloriesPerServing,
        culturalNote: dto.culturalNote,
        authorId,
        ingredients: {
          create: dto.ingredients.map((ing) => ({
            name: ing.name,
            qtyPerServing: ing.qtyPerServing,
            unit: ing.unit,
            optional: ing.optional || false,
            notes: ing.notes,
            gramEquivalent: ing.gramEquivalent,
            category: ing.category ?? IngredientCategory.OTHER,
            scaleStrategy: ing.scaleStrategy ?? ScaleStrategy.LINEAR,
            kcalPer100g: ing.kcalPer100g,
          })),
        },
        steps: {
          create: dto.steps.map((step) => ({
            order: step.order,
            description: step.description,
            defaultTimerSeconds: step.defaultTimerSeconds,
            mediaUrl: step.mediaUrl,
          })),
        },
        unlockConditions: dto.unlockConditions
          ? {
              create: dto.unlockConditions.map((uc) => ({
                conditionType: uc.conditionType,
                conditionData: uc.conditionData as Prisma.InputJsonValue,
                description: uc.description,
              })),
            }
          : undefined,
      },
      include: {
        ingredients: true,
        steps: { orderBy: { order: 'asc' } },
        unlockConditions: true,
      },
    });
  }

  async updateRecipe(id: string, dto: UpdateRecipeDto) {
    const recipe = await this.prisma.recipe.findUnique({ where: { id } });
    if (!recipe) throw new NotFoundException('Recipe not found');

    return this.prisma.recipe.update({
      where: { id },
      data: {
        ...dto,
        difficulty: dto.difficulty,
      },
      include: {
        ingredients: true,
        steps: { orderBy: { order: 'asc' } },
      },
    });
  }

  async deleteRecipe(id: string) {
    const recipe = await this.prisma.recipe.findUnique({ where: { id } });
    if (!recipe) throw new NotFoundException('Recipe not found');

    await this.prisma.recipe.delete({ where: { id } });
    return { message: 'Recipe deleted' };
  }

  async setUnlockConditions(
    recipeId: string,
    conditions: Array<{
      conditionType: string;
      conditionData: Record<string, unknown>;
      description: string;
    }>,
  ) {
    const recipe = await this.prisma.recipe.findUnique({
      where: { id: recipeId },
    });
    if (!recipe) throw new NotFoundException('Recipe not found');

    await this.prisma.$transaction(async (tx) => {
      await tx.unlockCondition.deleteMany({ where: { recipeId } });
      if (conditions.length > 0) {
        await tx.unlockCondition.createMany({
          data: conditions.map((c) => ({
            recipeId,
            conditionType: c.conditionType,
            conditionData: c.conditionData as Prisma.InputJsonValue,
            description: c.description,
          })),
        });
      }
    });

    return this.prisma.unlockCondition.findMany({ where: { recipeId } });
  }

  async getAnalyticsOverview() {
    const [
      totalRecipes,
      totalUsers,
      totalCompletions,
      topViewed,
      topCompleted,
      topRated,
    ] = await Promise.all([
      this.prisma.recipe.count(),
      this.prisma.user.count(),
      this.prisma.completionRecord.count(),
      this.prisma.recipe.findMany({
        orderBy: { viewCount: 'desc' },
        take: 10,
        select: {
          id: true,
          title: true,
          country: true,
          viewCount: true,
          completedCount: true,
          ratingAvg: true,
        },
      }),
      this.prisma.recipe.findMany({
        orderBy: { completedCount: 'desc' },
        take: 10,
        select: {
          id: true,
          title: true,
          country: true,
          completedCount: true,
          ratingAvg: true,
        },
      }),
      this.prisma.recipe.findMany({
        where: { ratingCount: { gte: 3 } },
        orderBy: { ratingAvg: 'desc' },
        take: 10,
        select: {
          id: true,
          title: true,
          country: true,
          ratingAvg: true,
          ratingCount: true,
        },
      }),
    ]);

    return {
      totals: { totalRecipes, totalUsers, totalCompletions },
      topViewed,
      topCompleted,
      topRated,
    };
  }

  async listUsers(page = 1, limit = 20) {
    const skip = (page - 1) * limit;

    const users = await this.prisma.user.findMany({
      skip,
      take: limit,
      select: {
        id: true,
        email: true,
        username: true,
        level: true,
        xp: true,
        completedCount: true,
        role: true,
        createdAt: true,
        _count: {
          select: {
            favorites: true,
            ratings: true,
            shoppingLists: true,
          },
        },
      },
      orderBy: { createdAt: 'desc' },
    });

    const total = await this.prisma.user.count();

    return {
      data: users,
      meta: { total, page, limit, totalPages: Math.ceil(total / limit) },
    };
  }
}
