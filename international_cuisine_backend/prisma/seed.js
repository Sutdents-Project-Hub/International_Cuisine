const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcryptjs');

const prisma = new PrismaClient();

async function seedAdmin() {
  const email = (process.env.SEED_ADMIN_EMAIL || '').trim();
  const username = (process.env.SEED_ADMIN_USERNAME || '').trim();
  const password = (process.env.SEED_ADMIN_PASSWORD || '').trim();

  if (!email || !username || !password) return;

  const passwordHash = await bcrypt.hash(password, 10);

  await prisma.user.upsert({
    where: { email },
    create: {
      email,
      username,
      passwordHash,
      role: 'ADMIN',
    },
    update: {
      username,
      passwordHash,
      role: 'ADMIN',
    },
  });
}

async function seedBadges() {
  const existing = await prisma.badge.count();
  if (existing > 0) return;

  await prisma.badge.createMany({
    data: [
      {
        name: 'Explorer',
        description: 'View recipes from multiple regions.',
        condition: { type: 'view_regions', threshold: 3 },
      },
      {
        name: 'Home Cook',
        description: 'Complete your first recipe.',
        condition: { type: 'complete_recipes', threshold: 1 },
      },
    ],
  });
}

async function seedRecipes() {
  const existing = await prisma.recipe.count();
  if (existing > 0) return;

  await prisma.recipe.create({
    data: {
      title: 'Classic Margherita Pizza',
      altTitles: [],
      country: 'Italy',
      region: 'Campania',
      city: 'Naples',
      cuisineTags: ['pizza', 'vegetarian'],
      isHidden: false,
      prepTimeMinutes: 20,
      cookTimeMinutes: 10,
      totalTimeMinutes: 30,
      difficulty: 'BEGINNER',
      servingsBase: 2,
      caloriesPerServing: 380,
      culturalNote: 'A simple Neapolitan classic with tomato, mozzarella, and basil.',
      ingredients: {
        create: [
          {
            name: 'Pizza dough',
            qtyPerServing: 150,
            unit: 'g',
            category: 'DRY_GOODS',
            scaleStrategy: 'LINEAR',
          },
          {
            name: 'Tomato sauce',
            qtyPerServing: 60,
            unit: 'g',
            category: 'OTHER',
            scaleStrategy: 'LINEAR',
          },
          {
            name: 'Mozzarella',
            qtyPerServing: 60,
            unit: 'g',
            category: 'REFRIGERATED',
            scaleStrategy: 'LINEAR',
          },
          {
            name: 'Basil',
            qtyPerServing: 2,
            unit: 'leaf',
            category: 'VEGETABLE',
            scaleStrategy: 'MIN_UNIT',
            optional: true,
          },
        ],
      },
      steps: {
        create: [
          { order: 1, description: 'Preheat oven to the hottest setting.' },
          { order: 2, description: 'Stretch dough and spread tomato sauce evenly.' },
          { order: 3, description: 'Add mozzarella and bake until bubbly and browned.' },
          { order: 4, description: 'Finish with basil and serve immediately.' },
        ],
      },
    },
  });

  await prisma.recipe.create({
    data: {
      title: 'Chicken Teriyaki Bowl',
      altTitles: [],
      country: 'Japan',
      region: 'Kanto',
      city: 'Tokyo',
      cuisineTags: ['rice', 'chicken'],
      isHidden: false,
      prepTimeMinutes: 15,
      cookTimeMinutes: 15,
      totalTimeMinutes: 30,
      difficulty: 'INTERMEDIATE',
      servingsBase: 2,
      caloriesPerServing: 520,
      culturalNote: 'Sweet-savory glaze served over rice with simple toppings.',
      ingredients: {
        create: [
          {
            name: 'Chicken thigh',
            qtyPerServing: 150,
            unit: 'g',
            category: 'MEAT',
            scaleStrategy: 'LINEAR',
          },
          {
            name: 'Soy sauce',
            qtyPerServing: 15,
            unit: 'ml',
            category: 'SEASONING',
            scaleStrategy: 'LINEAR',
          },
          {
            name: 'Mirin',
            qtyPerServing: 10,
            unit: 'ml',
            category: 'SEASONING',
            scaleStrategy: 'LINEAR',
            optional: true,
          },
          {
            name: 'Sugar',
            qtyPerServing: 5,
            unit: 'g',
            category: 'DRY_GOODS',
            scaleStrategy: 'LINEAR',
          },
          {
            name: 'Cooked rice',
            qtyPerServing: 180,
            unit: 'g',
            category: 'DRY_GOODS',
            scaleStrategy: 'LINEAR',
          },
        ],
      },
      steps: {
        create: [
          { order: 1, description: 'Mix soy sauce, mirin, and sugar to make sauce.' },
          { order: 2, description: 'Sear chicken until cooked through.' },
          { order: 3, description: 'Add sauce and reduce until glossy.' },
          { order: 4, description: 'Serve over rice.' },
        ],
      },
    },
  });
}

async function main() {
  await seedAdmin();
  await seedBadges();
  await seedRecipes();
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });

