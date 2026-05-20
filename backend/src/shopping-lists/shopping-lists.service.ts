import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateShoppingListDto } from './dto/create-shopping-list.dto';
import { IngredientCategory } from '@prisma/client';

@Injectable()
export class ShoppingListsService {
  constructor(private readonly prisma: PrismaService) {}

  async findAll(userId: string) {
    return this.prisma.shoppingList.findMany({
      where: { userId },
      include: {
        items: { orderBy: { category: 'asc' } },
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findOne(userId: string, id: string) {
    const list = await this.prisma.shoppingList.findFirst({
      where: { id, userId },
      include: {
        items: { orderBy: { category: 'asc' } },
      },
    });

    if (!list) {
      throw new NotFoundException('Shopping list not found');
    }

    return list;
  }

  async create(userId: string, dto: CreateShoppingListDto) {
    // Fetch all recipes with their ingredients
    const recipeIds = dto.recipes.map((r) => r.recipeId);
    const recipes = await this.prisma.recipe.findMany({
      where: { id: { in: recipeIds } },
      include: { ingredients: true },
    });
    const recipesById = new Map(recipes.map((r) => [r.id, r]));

    // Merge ingredients from all recipes with scaled quantities
    const ingredientMap = new Map<
      string,
      {
        ingredientName: string;
        totalQty: number;
        unit: string;
        category: IngredientCategory;
      }
    >();

    for (const recipePair of dto.recipes) {
      const recipe = recipesById.get(recipePair.recipeId);
      if (!recipe) continue;

      const scaleFactor = recipePair.servings / recipe.servingsBase;

      for (const ingredient of recipe.ingredients) {
        const key = `${ingredient.name.trim().toLowerCase()}\u0000${ingredient.unit}`;
        const existing = ingredientMap.get(key);

        if (existing) {
          existing.totalQty += ingredient.qtyPerServing * scaleFactor;
        } else {
          ingredientMap.set(key, {
            ingredientName: ingredient.name,
            totalQty: ingredient.qtyPerServing * scaleFactor,
            unit: ingredient.unit,
            category: ingredient.category,
          });
        }
      }
    }

    // Create the shopping list
    const title =
      dto.title || `Shopping List - ${new Date().toLocaleDateString('zh-TW')}`;

    const shoppingList = await this.prisma.shoppingList.create({
      data: {
        userId,
        title,
        items: {
          create: Array.from(ingredientMap.values()).map((value) => ({
            ingredientName: value.ingredientName,
            totalQty: Math.round(value.totalQty * 100) / 100,
            unit: value.unit,
            category: value.category,
          })),
        },
      },
      include: {
        items: { orderBy: { category: 'asc' } },
      },
    });

    return shoppingList;
  }

  async toggleItem(userId: string, listId: string, itemId: string) {
    // Verify ownership
    const list = await this.prisma.shoppingList.findFirst({
      where: { id: listId, userId },
    });
    if (!list) throw new NotFoundException('Shopping list not found');

    const item = await this.prisma.shoppingItem.findFirst({
      where: { id: itemId, shoppingListId: listId },
    });
    if (!item) throw new NotFoundException('Item not found');

    return this.prisma.shoppingItem.update({
      where: { id: itemId },
      data: { checked: !item.checked },
    });
  }

  async remove(userId: string, id: string) {
    const list = await this.prisma.shoppingList.findFirst({
      where: { id, userId },
    });
    if (!list) throw new NotFoundException('Shopping list not found');

    return this.prisma.shoppingList.delete({ where: { id } });
  }

  async exportCsv(userId: string, id: string): Promise<string> {
    const list = await this.findOne(userId, id);

    const header = 'Category,Ingredient,Quantity,Unit,Checked';
    const rows = list.items.map(
      (item) =>
        `${item.category},${item.ingredientName},${item.totalQty},${item.unit},${item.checked}`,
    );

    return [header, ...rows].join('\n');
  }
}
