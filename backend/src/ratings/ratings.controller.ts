import {
  Controller,
  Get,
  Post,
  Patch,
  Delete,
  Param,
  Body,
  UseGuards,
  Request,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
} from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RatingsService } from './ratings.service';
import { CreateRatingDto, UpdateRatingDto } from './dto/rating.dto';
import type { AuthenticatedRequest } from '../auth/auth.types';

@ApiTags('Ratings')
@Controller('recipes/:recipeId/ratings')
export class RatingsController {
  constructor(private readonly ratingsService: RatingsService) {}

  @Get()
  @ApiOperation({ summary: 'Get ratings for a recipe' })
  @ApiResponse({ status: 200, description: 'List of ratings with user info' })
  findByRecipe(@Param('recipeId') recipeId: string) {
    return this.ratingsService.findByRecipe(recipeId);
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Rate and comment on a recipe (1-5 stars)' })
  @ApiResponse({ status: 201, description: 'Rating created' })
  @ApiResponse({ status: 409, description: 'Already rated' })
  create(
    @Request() req: AuthenticatedRequest,
    @Param('recipeId') recipeId: string,
    @Body() dto: CreateRatingDto,
  ) {
    return this.ratingsService.create(req.user.id, recipeId, dto);
  }

  @Patch(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Update own rating' })
  @ApiResponse({ status: 200, description: 'Rating updated' })
  update(
    @Request() req: AuthenticatedRequest,
    @Param('recipeId') recipeId: string,
    @Param('id') id: string,
    @Body() dto: UpdateRatingDto,
  ) {
    return this.ratingsService.update(req.user.id, recipeId, id, dto);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Delete own rating' })
  @ApiResponse({ status: 200, description: 'Rating deleted' })
  remove(
    @Request() req: AuthenticatedRequest,
    @Param('recipeId') recipeId: string,
    @Param('id') id: string,
  ) {
    return this.ratingsService.remove(req.user.id, recipeId, id);
  }
}
