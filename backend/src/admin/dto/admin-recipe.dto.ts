import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsArray,
  IsBoolean,
  IsEnum,
  IsInt,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  Min,
  ValidateNested,
  ArrayNotEmpty,
} from 'class-validator';
import { Type } from 'class-transformer';
import { Difficulty, IngredientCategory, ScaleStrategy } from '@prisma/client';

class IngredientDto {
  @ApiProperty({ example: 'Soy Sauce' })
  @IsString()
  @IsNotEmpty()
  name!: string;

  @ApiProperty({ example: 15 })
  @IsNumber()
  qtyPerServing!: number;

  @ApiProperty({ example: 'ml' })
  @IsString()
  unit!: string;

  @ApiPropertyOptional({ example: false })
  @IsOptional()
  @IsBoolean()
  optional?: boolean;

  @ApiPropertyOptional({ example: 'Use dark soy sauce for better color' })
  @IsOptional()
  @IsString()
  notes?: string;

  @ApiPropertyOptional({ example: 15 })
  @IsOptional()
  @IsNumber()
  gramEquivalent?: number;

  @ApiPropertyOptional({
    enum: IngredientCategory,
  })
  @IsOptional()
  @IsEnum(IngredientCategory)
  category?: IngredientCategory;

  @ApiPropertyOptional({ enum: ScaleStrategy })
  @IsOptional()
  @IsEnum(ScaleStrategy)
  scaleStrategy?: ScaleStrategy;

  @ApiPropertyOptional({ example: 60 })
  @IsOptional()
  @IsNumber()
  kcalPer100g?: number;
}

class StepDto {
  @ApiProperty({ example: 1 })
  @IsInt()
  @Min(1)
  order!: number;

  @ApiProperty({ example: 'Mix all the sauce ingredients together' })
  @IsString()
  @IsNotEmpty()
  description!: string;

  @ApiPropertyOptional({ example: 30 })
  @IsOptional()
  @IsInt()
  defaultTimerSeconds?: number;

  @ApiPropertyOptional({ example: 'https://storage.example.com/step1.jpg' })
  @IsOptional()
  @IsString()
  mediaUrl?: string;
}

class UnlockConditionDto {
  @ApiProperty({ example: 'completion_count' })
  @IsString()
  conditionType!: string;

  @ApiProperty({ example: { count: 10 } })
  conditionData!: Record<string, unknown>;

  @ApiProperty({ example: 'Complete any 10 recipes to unlock' })
  @IsString()
  description!: string;
}

export class CreateRecipeDto {
  @ApiProperty({ example: 'Japanese Tonkatsu Ramen' })
  @IsString()
  @IsNotEmpty()
  title!: string;

  @ApiPropertyOptional({ example: ['Pork Bone Ramen', 'Tonkotsu'] })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  altTitles?: string[];

  @ApiProperty({ example: 'Japan' })
  @IsString()
  country!: string;

  @ApiPropertyOptional({ example: 'Asia' })
  @IsOptional()
  @IsString()
  region?: string;

  @ApiPropertyOptional({ example: 'Tokyo' })
  @IsOptional()
  @IsString()
  city?: string;

  @ApiPropertyOptional({ example: ['ramen', 'soup', 'pork'] })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  cuisineTags?: string[];

  @ApiPropertyOptional({ example: false })
  @IsOptional()
  @IsBoolean()
  isHidden?: boolean;

  @ApiProperty({ example: 30 })
  @IsInt()
  prepTimeMinutes!: number;

  @ApiProperty({ example: 120 })
  @IsInt()
  cookTimeMinutes!: number;

  @ApiProperty({ example: 150 })
  @IsInt()
  totalTimeMinutes!: number;

  @ApiProperty({ enum: Difficulty })
  @IsEnum(Difficulty)
  difficulty!: Difficulty;

  @ApiPropertyOptional({ example: 1 })
  @IsOptional()
  @IsInt()
  @Min(1)
  servingsBase?: number;

  @ApiPropertyOptional({ example: 550 })
  @IsOptional()
  @IsNumber()
  caloriesPerServing?: number;

  @ApiPropertyOptional({
    example: 'Tonkotsu ramen originated in Fukuoka, Japan, in the 1940s.',
  })
  @IsOptional()
  @IsString()
  culturalNote?: string;

  @ApiProperty({ type: [IngredientDto] })
  @IsArray()
  @ArrayNotEmpty()
  @ValidateNested({ each: true })
  @Type(() => IngredientDto)
  ingredients!: IngredientDto[];

  @ApiProperty({ type: [StepDto] })
  @IsArray()
  @ArrayNotEmpty()
  @ValidateNested({ each: true })
  @Type(() => StepDto)
  steps!: StepDto[];

  @ApiPropertyOptional({ type: [UnlockConditionDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => UnlockConditionDto)
  unlockConditions?: UnlockConditionDto[];
}

export class UpdateRecipeDto {
  @ApiPropertyOptional({ example: 'Updated Recipe Title' })
  @IsOptional()
  @IsString()
  title?: string;

  @ApiPropertyOptional({ example: 'Japan' })
  @IsOptional()
  @IsString()
  country?: string;

  @ApiPropertyOptional({ example: 'Asia' })
  @IsOptional()
  @IsString()
  region?: string;

  @ApiPropertyOptional({ example: false })
  @IsOptional()
  @IsBoolean()
  isHidden?: boolean;

  @ApiPropertyOptional({ example: 30 })
  @IsOptional()
  @IsInt()
  prepTimeMinutes?: number;

  @ApiPropertyOptional({ example: 120 })
  @IsOptional()
  @IsInt()
  cookTimeMinutes?: number;

  @ApiPropertyOptional({ example: 150 })
  @IsOptional()
  @IsInt()
  totalTimeMinutes?: number;

  @ApiPropertyOptional({ enum: Difficulty })
  @IsOptional()
  @IsEnum(Difficulty)
  difficulty?: Difficulty;

  @ApiPropertyOptional({ example: 550 })
  @IsOptional()
  @IsNumber()
  caloriesPerServing?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  culturalNote?: string;
}
