import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsEnum, IsOptional, IsString } from 'class-validator';
import { EventType } from '@prisma/client';

export class CreateEventDto {
  @ApiPropertyOptional({ example: 'recipe-uuid-here' })
  @IsOptional()
  @IsString()
  recipeId?: string;

  @ApiProperty({ enum: EventType })
  @IsEnum(EventType)
  eventType!: EventType;

  @ApiPropertyOptional({
    example: { source: 'home_page', duration_seconds: 120 },
  })
  @IsOptional()
  meta?: Record<string, unknown>;
}
