import {
  Injectable,
  NotFoundException,
  ForbiddenException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { QueryRecipesDto } from './dto/query-recipes.dto';
import {
  CreateRecipeDto,
  UpdateRecipeDto,
} from '../admin/dto/admin-recipe.dto';
import {
  Difficulty,
  IngredientCategory,
  Prisma,
  ScaleStrategy,
  type UnlockCondition,
} from '@prisma/client';

type UnlockStats = {
  completedCount: number;
  favoriteCount: number;
  continents: Set<string>;
  countryCompletionCounts: Map<string, number>;
};

@Injectable()
export class RecipesService {
  constructor(private readonly prisma: PrismaService) {}

  async findAll(query: QueryRecipesDto) {
    const page = query.page ?? 1;
    const limit = query.limit ?? 20;
    const skip = (page - 1) * limit;

    const where: Prisma.RecipeWhereInput = {};

    // Only show hidden recipes if user explicitly requests and has unlocked them
    if (!query.showHidden) {
      where.isHidden = false;
    }

    if (query.search) {
      where.OR = [
        { title: { contains: query.search, mode: 'insensitive' } },
        { altTitles: { has: query.search } },
        { country: { contains: query.search, mode: 'insensitive' } },
        { cuisineTags: { has: query.search } },
      ];
    }

    if (query.country) {
      where.country = { equals: query.country, mode: 'insensitive' };
    }

    if (query.difficulty) {
      where.difficulty = query.difficulty;
    }

    if (query.maxTime) {
      where.totalTimeMinutes = { lte: query.maxTime };
    }

    if (query.maxCalories) {
      where.caloriesPerServing = { lte: query.maxCalories };
    }

    if (query.cookingMethod) {
      where.cuisineTags = { has: query.cookingMethod };
    }

    // Build ingredient count filter using raw query if needed
    const recipes = await this.prisma.recipe.findMany({
      where,
      skip,
      take: limit,
      orderBy: { createdAt: 'desc' },
      select: {
        id: true,
        title: true,
        altTitles: true,
        country: true,
        region: true,
        cuisineTags: true,
        isHidden: true,
        prepTimeMinutes: true,
        cookTimeMinutes: true,
        totalTimeMinutes: true,
        difficulty: true,
        servingsBase: true,
        caloriesPerServing: true,
        viewCount: true,
        completedCount: true,
        likeCount: true,
        ratingAvg: true,
        ratingCount: true,
        createdAt: true,
        _count: {
          select: { ingredients: true },
        },
      },
    });

    // Post-filter by maxIngredients if specified
    let filtered = recipes;
    if (query.maxIngredients) {
      filtered = recipes.filter(
        (r) => r._count.ingredients <= (query.maxIngredients ?? Infinity),
      );
    }

    // Post-filter by diet preference (check ingredients)
    if (query.diet) {
      // Diet filtering is basic here - can be made more sophisticated
      // For now, filter by cuisineTags containing the diet keyword
    }

    const total = await this.prisma.recipe.count({ where });

    return {
      data: filtered,
      meta: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findOne(id: string) {
    try {
      return await this.prisma.recipe.update({
        where: { id },
        data: { viewCount: { increment: 1 } },
        include: {
          ingredients: { orderBy: { name: 'asc' } },
          steps: { orderBy: { order: 'asc' } },
          unlockConditions: true,
        },
      });
    } catch (err) {
      if (
        err instanceof Prisma.PrismaClientKnownRequestError &&
        err.code === 'P2025'
      ) {
        throw new NotFoundException('Recipe not found');
      }
      throw err;
    }
  }

  async create(userId: string, dto: CreateRecipeDto) {
    const { ingredients, steps, unlockConditions, ...rest } = dto;

    return this.prisma.recipe.create({
      data: {
        ...rest,
        difficulty: rest.difficulty,
        authorId: userId,
        // Default to 1500 if not provided, just a placeholder logic if needed, but DTO handles it optional
        // Actually the DTO makes ingredients mandatory which is good.
        ingredients: {
          create: ingredients.map((i) => ({
            ...i,
            scaleStrategy: i.scaleStrategy ?? ScaleStrategy.LINEAR,
            category: i.category ?? IngredientCategory.OTHER,
          })),
        },
        steps: {
          create: steps.map((s) => ({
            ...s,
          })),
        },
        // Only create unlock conditions if provided and valid
        unlockConditions: unlockConditions
          ? {
              create: unlockConditions.map((u) => ({
                conditionType: u.conditionType,
                conditionData: u.conditionData as Prisma.InputJsonValue,
                description: u.description,
              })),
            }
          : undefined,
      },
      include: {
        ingredients: true,
        steps: true,
        unlockConditions: true,
      },
    });
  }

  async update(userId: string, id: string, dto: UpdateRecipeDto) {
    // Check existence and ownership
    const recipe = await this.prisma.recipe.findUnique({
      where: { id },
    });

    if (!recipe) {
      throw new NotFoundException('Recipe not found');
    }

    if (recipe.authorId !== userId) {
      throw new ForbiddenException('You can only update your own recipes');
    }

    return this.prisma.recipe.update({
      where: { id },
      data: {
        ...dto,
        difficulty: dto.difficulty,
      },
    });
  }

  async remove(userId: string, id: string) {
    // Check existence and ownership
    const recipe = await this.prisma.recipe.findUnique({
      where: { id },
    });

    if (!recipe) {
      throw new NotFoundException('Recipe not found');
    }

    if (recipe.authorId !== userId) {
      throw new ForbiddenException('You can only delete your own recipes');
    }

    return this.prisma.recipe.delete({
      where: { id },
    });
  }

  async getScaledRecipe(id: string, targetServings: number) {
    const recipe = await this.prisma.recipe.findUnique({
      where: { id },
      include: {
        ingredients: true,
        steps: { orderBy: { order: 'asc' } },
      },
    });

    if (!recipe) {
      throw new NotFoundException('Recipe not found');
    }

    const scaleFactor = targetServings / recipe.servingsBase;

    const scaledIngredients = recipe.ingredients.map((ingredient) => {
      let scaledQty: number;

      switch (ingredient.scaleStrategy) {
        case ScaleStrategy.CLAMPED:
          // Scale but clamp between 0.5x and 3x of original
          scaledQty = Math.max(
            ingredient.qtyPerServing * 0.5,
            Math.min(
              ingredient.qtyPerServing * 3,
              ingredient.qtyPerServing * scaleFactor,
            ),
          );
          break;
        case ScaleStrategy.MIN_UNIT:
          // Round to nearest 0.25 unit
          scaledQty =
            Math.round(ingredient.qtyPerServing * scaleFactor * 4) / 4;
          break;
        case ScaleStrategy.LINEAR:
        default:
          scaledQty = ingredient.qtyPerServing * scaleFactor;
          break;
      }

      return {
        ...ingredient,
        scaledQty: Math.round(scaledQty * 100) / 100, // round to 2 decimals
        originalQtyPerServing: ingredient.qtyPerServing,
      };
    });

    // Calculate total calories for scaled servings
    const totalCalories = recipe.caloriesPerServing
      ? recipe.caloriesPerServing * targetServings
      : null;

    return {
      ...recipe,
      targetServings,
      scaleFactor,
      ingredients: scaledIngredients,
      totalCalories,
      caloriesPerServing: recipe.caloriesPerServing,
    };
  }

  async completeRecipe(userId: string, recipeId: string) {
    const result = await this.prisma.$transaction(async (tx) => {
      const recipe = await tx.recipe.findUnique({
        where: { id: recipeId },
        select: { difficulty: true },
      });

      if (!recipe) throw new NotFoundException('Recipe not found');

      await tx.completionRecord.create({
        data: { userId, recipeId },
      });

      await tx.recipe.update({
        where: { id: recipeId },
        data: { completedCount: { increment: 1 } },
      });

      const xpGain = this.calculateXp(recipe.difficulty);
      const user = await tx.user.update({
        where: { id: userId },
        data: {
          completedCount: { increment: 1 },
          xp: { increment: xpGain },
        },
        select: { xp: true, level: true, completedCount: true },
      });

      const computedLevel = Math.floor(user.xp / 100) + 1;
      const level = computedLevel > user.level ? computedLevel : user.level;
      if (computedLevel > user.level) {
        await tx.user.update({
          where: { id: userId },
          data: { level: computedLevel },
        });
      }

      return {
        xpGain,
        totalXp: user.xp,
        level,
        completedCount: user.completedCount,
      };
    });

    const unlockedRecipes = await this.checkUnlocks(userId);
    return { ...result, newUnlocks: unlockedRecipes };
  }

  async unlockRecipe(userId: string, recipeId: string) {
    const recipe = await this.prisma.recipe.findUnique({
      where: { id: recipeId },
      include: { unlockConditions: true },
    });

    if (!recipe) {
      throw new NotFoundException('Recipe not found');
    }

    if (!recipe.isHidden) {
      return { message: 'Recipe is not hidden, no unlock needed' };
    }

    // Verify all conditions are met
    const stats = await this.getUserUnlockStats(userId);
    const conditionsMet = this.verifyUnlockConditions(
      recipe.unlockConditions,
      stats,
    );

    if (!conditionsMet) {
      return {
        unlocked: false,
        message: 'Unlock conditions not met',
        conditions: recipe.unlockConditions.map((c) => ({
          type: c.conditionType,
          description: c.description,
        })),
      };
    }

    // Unlock the recipe
    await this.prisma.userUnlockedRecipe.upsert({
      where: {
        userId_recipeId: { userId, recipeId },
      },
      create: { userId, recipeId },
      update: {},
    });

    return { unlocked: true, message: 'Recipe unlocked!' };
  }

  async getCountriesByContinent() {
    const recipes = await this.prisma.recipe.findMany({
      where: { isHidden: false },
      select: { country: true, region: true, cuisineTags: true },
      distinct: ['country'],
    });

    // Group by continent (stored in cuisineTags or region)
    const continentMap = new Map<string, Set<string>>();
    for (const recipe of recipes) {
      const continent = recipe.region || 'Other';
      if (!continentMap.has(continent)) {
        continentMap.set(continent, new Set());
      }
      continentMap.get(continent)!.add(recipe.country);
    }

    const result: Record<string, string[]> = {};
    for (const [continent, countries] of continentMap) {
      result[continent] = Array.from(countries).sort();
    }

    return result;
  }

  private calculateXp(difficulty: string): number {
    switch (difficulty) {
      case Difficulty.ADVANCED:
        return 30;
      case Difficulty.INTERMEDIATE:
        return 20;
      case Difficulty.BEGINNER:
      default:
        return 10;
    }
  }

  private async checkUnlocks(userId: string): Promise<string[]> {
    // Find hidden recipes with unlock conditions that might be met
    const hiddenRecipes = await this.prisma.recipe.findMany({
      where: {
        isHidden: true,
        unlockedBy: { none: { userId } },
      },
      include: { unlockConditions: true },
    });

    const stats = await this.getUserUnlockStats(userId);
    const newUnlocks: string[] = [];
    const toCreate: Array<Prisma.UserUnlockedRecipeCreateManyInput> = [];

    for (const recipe of hiddenRecipes) {
      if (recipe.unlockConditions.length === 0) continue;

      const met = this.verifyUnlockConditions(recipe.unlockConditions, stats);
      if (met) {
        toCreate.push({ userId, recipeId: recipe.id });
        newUnlocks.push(recipe.title);
      }
    }

    if (toCreate.length > 0) {
      await this.prisma.userUnlockedRecipe.createMany({
        data: toCreate,
        skipDuplicates: true,
      });
    }

    return newUnlocks;
  }

  private async getUserUnlockStats(userId: string): Promise<UnlockStats> {
    const [user, favoriteCount, completions] = await Promise.all([
      this.prisma.user.findUnique({
        where: { id: userId },
        select: { completedCount: true },
      }),
      this.prisma.favorite.count({ where: { userId } }),
      this.prisma.completionRecord.findMany({
        where: { userId },
        select: {
          recipe: {
            select: { region: true, country: true },
          },
        },
      }),
    ]);

    const continents = new Set<string>();
    const countryCompletionCounts = new Map<string, number>();
    for (const c of completions) {
      if (c.recipe.region) continents.add(c.recipe.region);
      if (c.recipe.country) {
        const key = c.recipe.country.trim().toLowerCase();
        countryCompletionCounts.set(
          key,
          (countryCompletionCounts.get(key) ?? 0) + 1,
        );
      }
    }

    return {
      completedCount: user?.completedCount ?? 0,
      favoriteCount,
      continents,
      countryCompletionCounts,
    };
  }

  private verifyUnlockConditions(
    conditions: Array<
      Pick<UnlockCondition, 'conditionType' | 'conditionData' | 'description'>
    >,
    stats: UnlockStats,
  ): boolean {
    for (const condition of conditions) {
      const raw = condition.conditionData as unknown;
      const data =
        typeof raw === 'object' && raw !== null
          ? (raw as Record<string, unknown>)
          : {};
      const count =
        typeof data.count === 'number'
          ? data.count
          : typeof data.count === 'string'
            ? Number.parseInt(data.count, 10)
            : 0;
      const required = Number.isFinite(count) ? count : 0;

      switch (condition.conditionType) {
        case 'completion_count': {
          if (stats.completedCount < required) return false;
          break;
        }
        case 'continent_diversity': {
          if (stats.continents.size < required) return false;
          break;
        }
        case 'country_mastery': {
          const country = typeof data.country === 'string' ? data.country : '';
          if (!country) return false;
          const key = country.trim().toLowerCase();
          const completed = stats.countryCompletionCounts.get(key) ?? 0;
          if (completed < required) return false;
          break;
        }
        case 'favorite_count': {
          if (stats.favoriteCount < required) return false;
          break;
        }
        default:
          // Unknown condition type, skip
          break;
      }
    }

    return true;
  }
}
