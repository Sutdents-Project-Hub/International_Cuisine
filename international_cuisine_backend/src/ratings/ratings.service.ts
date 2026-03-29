import {
  Injectable,
  NotFoundException,
  ConflictException,
  ForbiddenException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateRatingDto, UpdateRatingDto } from './dto/rating.dto';

@Injectable()
export class RatingsService {
  constructor(private readonly prisma: PrismaService) {}

  async findByRecipe(recipeId: string) {
    const ratings = await this.prisma.rating.findMany({
      where: { recipeId },
      include: {
        user: { select: { id: true, username: true, avatarUrl: true } },
      },
      orderBy: { createdAt: 'desc' },
    });

    return ratings;
  }

  async create(userId: string, recipeId: string, dto: CreateRatingDto) {
    // Check if recipe exists
    const recipe = await this.prisma.recipe.findUnique({
      where: { id: recipeId },
    });
    if (!recipe) throw new NotFoundException('Recipe not found');

    // Check if already rated
    const existing = await this.prisma.rating.findUnique({
      where: { userId_recipeId: { userId, recipeId } },
    });
    if (existing)
      throw new ConflictException('You have already rated this recipe');

    const rating = await this.prisma.rating.create({
      data: {
        userId,
        recipeId,
        score: dto.score,
        comment: dto.comment,
      },
    });

    // Update recipe average rating
    await this.updateRecipeRating(recipeId);

    return rating;
  }

  async update(
    userId: string,
    recipeId: string,
    ratingId: string,
    dto: UpdateRatingDto,
  ) {
    const rating = await this.prisma.rating.findFirst({
      where: { id: ratingId, recipeId },
    });
    if (!rating) throw new NotFoundException('Rating not found');
    if (rating.userId !== userId)
      throw new ForbiddenException('You can only update your own ratings');

    const updated = await this.prisma.rating.update({
      where: { id: ratingId },
      data: dto,
    });

    await this.updateRecipeRating(recipeId);

    return updated;
  }

  async remove(userId: string, recipeId: string, ratingId: string) {
    const rating = await this.prisma.rating.findFirst({
      where: { id: ratingId, recipeId },
    });
    if (!rating) throw new NotFoundException('Rating not found');
    if (rating.userId !== userId)
      throw new ForbiddenException('You can only delete your own ratings');

    await this.prisma.rating.delete({ where: { id: ratingId } });
    await this.updateRecipeRating(recipeId);

    return { message: 'Rating deleted' };
  }

  private async updateRecipeRating(recipeId: string) {
    const agg = await this.prisma.rating.aggregate({
      where: { recipeId },
      _avg: { score: true },
      _count: { score: true },
    });

    await this.prisma.recipe.update({
      where: { id: recipeId },
      data: {
        ratingAvg: agg._avg.score ?? 0,
        ratingCount: agg._count.score,
      },
    });
  }
}
