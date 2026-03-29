import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsInt, IsOptional, IsString, Max, Min } from 'class-validator';

export class CreateRatingDto {
  @ApiProperty({ example: 5, description: 'Rating score from 1 to 5' })
  @IsInt()
  @Min(1)
  @Max(5)
  score!: number;

  @ApiPropertyOptional({ example: 'Delicious recipe! Very easy to follow.' })
  @IsOptional()
  @IsString()
  comment?: string;
}

export class UpdateRatingDto {
  @ApiPropertyOptional({ example: 4 })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(5)
  score?: number;

  @ApiPropertyOptional({
    example: 'Updated: Still great but added more spice!',
  })
  @IsOptional()
  @IsString()
  comment?: string;
}
