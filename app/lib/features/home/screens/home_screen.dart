import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/premium_widgets.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/providers/user_provider.dart';
import '../../recipe/models/recipe.dart';
import '../../recipe/providers/recipe_provider.dart';
import '../../recipe/screens/recipe_detail_screen.dart';
import '../../recipe/widgets/recipe_card.dart';
import '../../unlock/providers/unlock_provider.dart';
import '../../recipe/screens/create_recipe_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final rp = context.read<RecipeProvider>();
      if (rp.recipes.isEmpty) rp.fetchRecipes();
      context.read<UserProvider>().fetchUserStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final provider = context.watch<RecipeProvider>();
    final userProvider = context.watch<UserProvider>();
    final unlockProvider = context.watch<UnlockProvider>();
    final recipes = provider.recipes;

    if (provider.isLoading && recipes.isEmpty) {
      return _buildShimmerLoading();
    }

    // Sync unlock data
    if (recipes.isNotEmpty) {
      unlockProvider.sync(
        recipes: recipes,
        unlockedRecipes: userProvider.unlockedRecipes,
      );
    }

    final recommended = recipes.take(6).toList();
    final popular = recipes.where((r) => r.viewCount > 5).take(6).toList();
    final continents = provider.countriesByContinent.keys.toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateRecipeScreen()),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        icon: const Icon(Icons.add),
        label: const Text('New Recipe'),
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.surface,
        onRefresh: () async {
          await provider.fetchRecipes();
          await userProvider.fetchUserStats();
        },
        child: AnimationLimiter(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: 80,
            ), // Add padding for FAB & Status Bar
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 400),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 30,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                // ── Greeting Header ──
                _buildGreeting(auth, userProvider),

                // ── Continent Chips ──
                if (continents.isNotEmpty) _buildContinentChips(continents),

                const SizedBox(height: 8),

                // ── Unlock Progress ──
                _buildUnlockProgress(unlockProvider),

                const SizedBox(height: 8),

                // ── Recommended Recipes ──
                if (recommended.isNotEmpty) ...[
                  const SectionHeader(title: 'Recommended For You'),
                  const SizedBox(height: 4),
                  _buildHorizontalRecipeList(recommended, 'rec'),
                ],

                const SizedBox(height: 16),

                // ── Popular Recipes ──
                if (popular.isNotEmpty) ...[
                  const SectionHeader(title: 'Popular Recipes'),
                  const SizedBox(height: 4),
                  _buildHorizontalRecipeList(popular, 'pop'),
                ],

                // ── Hidden Recipes Teaser ──
                if (unlockProvider.lockedRecipes.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const SectionHeader(title: 'Hidden Recipes'),
                  const SizedBox(height: 4),
                  _buildLockedRecipeList(unlockProvider.lockedRecipes),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting(AuthProvider auth, UserProvider userProvider) {
    final name = auth.user?['username'] ?? 'Chef';
    final level = userProvider.levelInfo?.level ?? 1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _greetingText(),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: AppColors.heroGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.local_fire_department_rounded,
                  size: 16,
                  color: AppColors.textOnPrimary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Lv $level',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textOnPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinentChips(List<String> continents) {
    return SizedBox(
      height: 100, // Increased height for cards
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        itemCount: continents.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final continent = continents[index];
          final color = AppColors.continentColor(continent);
          // Map continent name to asset
          final assetName =
              'assets/images/category_${continent.toLowerCase()}.png';

          return GestureDetector(
            onTap: () {
              final rp = context.read<RecipeProvider>();
              rp.updateFilter(rp.filter.copyWith(continent: continent));
            },
            child: Container(
              width: 140, // Wider card
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(assetName),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.3),
                    BlendMode.darken,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                continent,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUnlockProgress(UnlockProvider unlockProvider) {
    final progress = unlockProvider.progress();
    final unlocked = unlockProvider.unlockedCount;
    final total = unlocked + unlockProvider.lockedRecipes.length;

    if (total == 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircularPercentIndicator(
              radius: 30,
              lineWidth: 5,
              percent: progress.clamp(0.0, 1.0),
              center: Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              progressColor: AppColors.primary,
              backgroundColor: AppColors.divider,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              animationDuration: 800,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Unlock Progress',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$unlocked of $total hidden recipes unlocked',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.lock_open_rounded,
              color: AppColors.secondary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalRecipeList(List<Recipe> recipes, String tagPrefix) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: recipes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          final tag = '$tagPrefix-${recipe.id}';
          return SizedBox(
            width: 280,
            child: RecipeCard(
              recipe: recipe,
              heroTag: tag,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        RecipeDetailScreen(recipe: recipe, heroTag: tag),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildLockedRecipeList(List<Recipe> recipes) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: recipes.take(4).length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return SizedBox(
            width: 200,
            child: RecipeCard(recipe: recipe, onTap: () {}),
          );
        },
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const ShimmerBox(height: 50, borderRadius: 12),
        const SizedBox(height: 16),
        const ShimmerBox(height: 40, borderRadius: 20),
        const SizedBox(height: 20),
        const ShimmerBox(height: 80, borderRadius: 16),
        const SizedBox(height: 20),
        const ShimmerBox(height: 200, borderRadius: 18),
        const SizedBox(height: 16),
        const ShimmerBox(height: 200, borderRadius: 18),
      ],
    );
  }

  String _greetingText() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning,';
    if (hour < 18) return 'Good afternoon,';
    return 'Good evening,';
  }
}
