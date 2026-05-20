import {
  Controller,
  Get,
  Post,
  Patch,
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
import { AdminGuard } from './guards/admin.guard';
import { AdminService } from './admin.service';
import { CreateRecipeDto, UpdateRecipeDto } from './dto/admin-recipe.dto';
import type { AuthenticatedRequest } from '../auth/auth.types';

@ApiTags('Admin')
@Controller('admin')
@UseGuards(JwtAuthGuard, AdminGuard)
@ApiBearerAuth()
export class AdminController {
  constructor(private readonly adminService: AdminService) {}

  @Post('recipes')
  @ApiOperation({
    summary: '[Admin] Create a new recipe with ingredients and steps',
  })
  @ApiResponse({ status: 201, description: 'Recipe created' })
  @ApiResponse({ status: 403, description: 'Admin access required' })
  createRecipe(
    @Request() req: AuthenticatedRequest,
    @Body() dto: CreateRecipeDto,
  ) {
    return this.adminService.createRecipe(req.user.id, dto);
  }

  @Patch('recipes/:id')
  @ApiOperation({ summary: '[Admin] Update a recipe' })
  @ApiResponse({ status: 200, description: 'Recipe updated' })
  updateRecipe(@Param('id') id: string, @Body() dto: UpdateRecipeDto) {
    return this.adminService.updateRecipe(id, dto);
  }

  @Delete('recipes/:id')
  @ApiOperation({ summary: '[Admin] Delete a recipe' })
  @ApiResponse({ status: 200, description: 'Recipe deleted' })
  deleteRecipe(@Param('id') id: string) {
    return this.adminService.deleteRecipe(id);
  }

  @Post('recipes/:id/unlock-conditions')
  @ApiOperation({
    summary: '[Admin] Set unlock conditions for a hidden recipe',
  })
  @ApiResponse({ status: 201, description: 'Unlock conditions set' })
  setUnlockConditions(
    @Param('id') id: string,
    @Body()
    conditions: Array<{
      conditionType: string;
      conditionData: Record<string, unknown>;
      description: string;
    }>,
  ) {
    return this.adminService.setUnlockConditions(id, conditions);
  }

  @Get('analytics/overview')
  @ApiOperation({ summary: '[Admin] Get analytics dashboard overview' })
  @ApiResponse({ status: 200, description: 'Dashboard stats with top recipes' })
  getAnalyticsOverview() {
    return this.adminService.getAnalyticsOverview();
  }

  @Get('users')
  @ApiOperation({ summary: '[Admin] List all users with stats' })
  @ApiQuery({ name: 'page', required: false, type: Number })
  @ApiQuery({ name: 'limit', required: false, type: Number })
  @ApiResponse({ status: 200, description: 'Paginated user list' })
  listUsers(@Query('page') page?: string, @Query('limit') limit?: string) {
    return this.adminService.listUsers(
      parseInt(page || '1', 10),
      parseInt(limit || '20', 10),
    );
  }
}
