import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/premium_widgets.dart';
import '../providers/favorites_provider.dart';
import '../../recipe/widgets/recipe_card.dart';
import '../../recipe/screens/recipe_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final fp = context.read<FavoritesProvider>();
      fp.fetchCategories();
      fp.fetchFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavoritesProvider>();
    final favorites = provider.favorites;
    final categories = provider.categories;

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Column(
        children: [
          // ── Category Chips ──
          if (categories.isNotEmpty)
            SizedBox(
              height: 46,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                itemCount: categories.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    final selected = provider.selectedCategory == null;
                    return ChoiceChip(
                      label: const Text('All'),
                      selected: selected,
                      onSelected: (_) => provider.selectCategory(null),
                      selectedColor: AppColors.primary.withValues(alpha: 0.2),
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: selected
                            ? AppColors.primary
                            : AppColors.textMuted,
                      ),
                    );
                  }
                  final cat = categories[index - 1];
                  final selected = provider.selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: selected,
                    onSelected: (_) => provider.selectCategory(cat),
                    selectedColor: AppColors.primary.withValues(alpha: 0.2),
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: selected ? AppColors.primary : AppColors.textMuted,
                    ),
                  );
                },
              ),
            ),

          // ── Content ──
          Expanded(
            child: provider.isLoading
                ? _buildLoading()
                : favorites.isEmpty
                ? const EmptyStateWidget(
                    imageAsset: 'assets/images/empty_favorites.png',
                    title: 'No favorites yet',
                    subtitle: 'Tap the heart icon on any recipe to add it here',
                  )
                : AnimationLimiter(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemCount: favorites.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 350),
                          child: SlideAnimation(
                            horizontalOffset: 40,
                            child: FadeInAnimation(
                              child: Dismissible(
                                key: ValueKey(favorites[index].id),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    color: AppColors.error.withValues(
                                      alpha: 0.15,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: const Icon(
                                    Icons.delete_rounded,
                                    color: AppColors.error,
                                  ),
                                ),
                                onDismissed: (_) => provider.removeFavorite(
                                  favorites[index].id,
                                ),
                                child: RecipeCard(
                                  recipe: favorites[index],
                                  heroTag: 'fav-${favorites[index].id}',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => RecipeDetailScreen(
                                          recipe: favorites[index],
                                          heroTag: 'fav-${favorites[index].id}',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        ShimmerBox(height: 200),
        SizedBox(height: 14),
        ShimmerBox(height: 200),
      ],
    );
  }
}
