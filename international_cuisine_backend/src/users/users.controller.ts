import {
  Controller,
  Get,
  Patch,
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
import { UsersService } from './users.service';
import { UpdateProfileDto } from './dto/update-profile.dto';
import type { AuthenticatedRequest } from '../auth/auth.types';

@ApiTags('Users')
@Controller('users')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Patch('profile')
  @ApiOperation({ summary: 'Update user profile' })
  @ApiResponse({ status: 200, description: 'Profile updated successfully' })
  updateProfile(
    @Request() req: AuthenticatedRequest,
    @Body() dto: UpdateProfileDto,
  ) {
    return this.usersService.updateProfile(req.user.id, dto);
  }

  @Get('achievements')
  @ApiOperation({ summary: 'Get user achievements (badges, unlocked recipes)' })
  @ApiResponse({ status: 200, description: 'User achievements' })
  getAchievements(@Request() req: AuthenticatedRequest) {
    return this.usersService.getAchievements(req.user.id);
  }

  @Get('level')
  @ApiOperation({ summary: 'Get user level info and XP progress' })
  @ApiResponse({ status: 200, description: 'Level info with XP progress' })
  getLevelInfo(@Request() req: AuthenticatedRequest) {
    return this.usersService.getLevelInfo(req.user.id);
  }
}
