import {
  Controller,
  Get,
  Post,
  Delete,
  Param,
  Body,
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
import { FavoritesService } from './favorites.service';
import { CreateFavoriteDto } from './dto/create-favorite.dto';
import type { AuthenticatedRequest } from '../auth/auth.types';

@ApiTags('Favorites')
@Controller('favorites')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class FavoritesController {
  constructor(private readonly favoritesService: FavoritesService) {}

  @Get()
  @ApiOperation({ summary: 'List user favorites, optionally by category' })
  @ApiQuery({ name: 'category', required: false })
  @ApiResponse({ status: 200, description: 'List of favorites' })
  findAll(
    @Request() req: AuthenticatedRequest,
    @Query('category') category?: string,
  ) {
    return this.favoritesService.findAll(req.user.id, category);
  }

  @Post()
  @ApiOperation({ summary: 'Add a recipe to favorites' })
  @ApiResponse({ status: 201, description: 'Added to favorites' })
  @ApiResponse({ status: 409, description: 'Already in favorites' })
  create(@Request() req: AuthenticatedRequest, @Body() dto: CreateFavoriteDto) {
    return this.favoritesService.create(req.user.id, dto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Remove a recipe from favorites' })
  @ApiResponse({ status: 200, description: 'Removed from favorites' })
  @ApiResponse({ status: 404, description: 'Favorite not found' })
  remove(@Request() req: AuthenticatedRequest, @Param('id') id: string) {
    return this.favoritesService.remove(req.user.id, id);
  }

  @Get('categories')
  @ApiOperation({ summary: 'List custom favorite categories' })
  @ApiResponse({ status: 200, description: 'List of category names' })
  getCategories(@Request() req: AuthenticatedRequest) {
    return this.favoritesService.getCategories(req.user.id);
  }
}
