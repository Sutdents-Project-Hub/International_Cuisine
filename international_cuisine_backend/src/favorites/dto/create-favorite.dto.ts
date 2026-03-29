import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsNotEmpty, IsString, IsOptional } from 'class-validator';

export class CreateFavoriteDto {
  @ApiProperty({ example: 'recipe-uuid-here' })
  @IsString()
  @IsNotEmpty()
  recipeId!: string;

  @ApiPropertyOptional({
    example: 'dinner',
    description: 'Custom category name for organizing favorites',
  })
  @IsOptional()
  @IsString()
  categoryName?: string;
}
