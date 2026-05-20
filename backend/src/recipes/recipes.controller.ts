import {
  Controller,
  Get,
  Post,
  Patch,
  Delete,
  Body,
  Param,
  Query,
  UseGuards,
  Request,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
  ApiQuery,
} from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RecipesService } from './recipes.service';
import { QueryRecipesDto } from './dto/query-recipes.dto';
import {
  CreateRecipeDto,
  UpdateRecipeDto,
} from '../admin/dto/admin-recipe.dto';
import type { AuthenticatedRequest } from '../auth/auth.types';

@ApiTags('Recipes')
@Controller('recipes')
export class RecipesController {
  constructor(private readonly recipesService: RecipesService) {}

  @Get()
  @ApiOperation({ summary: 'List recipes with search and filters' })
  @ApiResponse({ status: 200, description: 'Paginated recipe list' })
  findAll(@Query() query: QueryRecipesDto) {
    return this.recipesService.findAll(query);
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Create a new recipe' })
  @ApiResponse({ status: 201, description: 'Recipe created successfully' })
  create(@Request() req: AuthenticatedRequest, @Body() dto: CreateRecipeDto) {
    // User ID is attached to the request by JwtAuthGuard
    return this.recipesService.create(req.user.id, dto);
  }

  @Patch(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Update your own recipe' })
  @ApiResponse({ status: 200, description: 'Recipe updated successfully' })
  @ApiResponse({
    status: 403,
    description: 'Forbidden: You can only update your own recipes',
  })
  update(
    @Param('id') id: string,
    @Request() req: AuthenticatedRequest,
    @Body() dto: UpdateRecipeDto,
  ) {
    return this.recipesService.update(req.user.id, id, dto);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Delete your own recipe' })
  @ApiResponse({ status: 200, description: 'Recipe deleted successfully' })
  @ApiResponse({
    status: 403,
    description: 'Forbidden: You can only delete your own recipes',
  })
  remove(@Param('id') id: string, @Request() req: AuthenticatedRequest) {
    return this.recipesService.remove(req.user.id, id);
  }

  @Get('countries')
  @ApiOperation({ summary: 'Get available countries grouped by continent' })
  @ApiResponse({ status: 200, description: 'Countries grouped by continent' })
  getCountries() {
    return this.recipesService.getCountriesByContinent();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get recipe detail (auto-increments view count)' })
  @ApiResponse({
    status: 200,
    description: 'Recipe with ingredients and steps',
  })
  @ApiResponse({ status: 404, description: 'Recipe not found' })
  findOne(@Param('id') id: string) {
    return this.recipesService.findOne(id);
  }

  @Get(':id/scale')
  @ApiOperation({ summary: 'Get recipe with scaled servings' })
  @ApiQuery({ name: 'servings', type: Number, example: 4 })
  @ApiResponse({
    status: 200,
    description: 'Recipe with scaled ingredient quantities',
  })
  getScaled(@Param('id') id: string, @Query('servings') servings: string) {
    return this.recipesService.getScaledRecipe(id, parseInt(servings, 10) || 1);
  }

  @Post(':id/complete')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({
    summary: 'Mark recipe as completed (earn XP, check level up and unlocks)',
  })
  @ApiResponse({
    status: 201,
    description: 'Completion recorded, XP and level info returned',
  })
  complete(@Param('id') id: string, @Request() req: AuthenticatedRequest) {
    return this.recipesService.completeRecipe(req.user.id, id);
  }

  @Post(':id/unlock')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Attempt to unlock a hidden recipe' })
  @ApiResponse({
    status: 201,
    description: 'Unlock result with condition status',
  })
  unlock(@Param('id') id: string, @Request() req: AuthenticatedRequest) {
    return this.recipesService.unlockRecipe(req.user.id, id);
  }
}
