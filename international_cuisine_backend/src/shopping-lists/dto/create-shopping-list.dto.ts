import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsArray,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Min,
} from 'class-validator';
import { Type } from 'class-transformer';

class RecipeServingPair {
  @ApiProperty({ example: 'recipe-uuid-here' })
  @IsString()
  @IsNotEmpty()
  recipeId!: string;

  @ApiProperty({ example: 2 })
  @Type(() => Number)
  @IsInt()
  @Min(1)
  servings!: number;
}

export class CreateShoppingListDto {
  @ApiPropertyOptional({ example: 'Weekend Cooking' })
  @IsOptional()
  @IsString()
  title?: string;

  @ApiProperty({
    type: [RecipeServingPair],
    description: 'Array of recipe IDs with desired servings',
  })
  @IsArray()
  recipes!: RecipeServingPair[];
}
