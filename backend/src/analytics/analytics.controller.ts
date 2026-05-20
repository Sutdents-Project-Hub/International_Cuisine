import {
  Controller,
  Get,
  Post,
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
import { AnalyticsService } from './analytics.service';
import { CreateEventDto } from './dto/create-event.dto';
import type { AuthenticatedRequest } from '../auth/auth.types';

@ApiTags('Analytics')
@Controller('analytics')
export class AnalyticsController {
  constructor(private readonly analyticsService: AnalyticsService) {}

  @Post('events')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({
    summary: 'Track an analytics event (view, start, complete, favorite)',
  })
  @ApiResponse({ status: 201, description: 'Event recorded' })
  trackEvent(
    @Request() req: AuthenticatedRequest,
    @Body() dto: CreateEventDto,
  ) {
    return this.analyticsService.trackEvent(req.user.id, dto);
  }

  @Get('stats')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Get user analytics stats' })
  @ApiResponse({ status: 200, description: 'User stats overview' })
  getStats(@Request() req: AuthenticatedRequest) {
    return this.analyticsService.getUserStats(req.user.id);
  }
}
