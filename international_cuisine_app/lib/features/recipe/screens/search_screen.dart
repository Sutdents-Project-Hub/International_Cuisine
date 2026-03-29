import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/premium_widgets.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import 'recipe_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final rp = context.read<RecipeProvider>();
      if (rp.recipes.isEmpty) rp.fetchRecipes();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _search(String query) {
    if (query.trim().isEmpty) return;
    context.read<RecipeProvider>().applyNaturalLanguageFilter(query);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipeProvider>();
    final recipes = provider.recipes;
    final recentSearches = provider.recentSearches;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          IconButton(
            onPressed: () => _showFilters(context),
            icon: const Icon(Icons.tune_rounded),
            tooltip: 'Filters',
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Search Bar ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              onSubmitted: _search,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search recipes, countries, ingredients...',
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.textMuted,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          provider.fetchRecipes();
                          setState(() {});
                        },
                        icon: const Icon(Icons.close_rounded, size: 20),
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),

          // ── Quick Filter Chips ──
          SizedBox(
            height: 38,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _quickChip('🔥 Popular', () {
                  _searchController.text = 'popular';
                  _search('popular');
                }),
                _quickChip('⚡ Quick Meals', () {
                  _searchController.text = 'under 30 min';
                  _search('under 30 min');
                }),
                _quickChip('🥗 Vegetarian', () {
                  _searchController.text = 'vegetarian';
                  _search('vegetarian');
                }),
                _quickChip('🌶 Asian', () {
                  final rp = context.read<RecipeProvider>();
                  rp.updateFilter(rp.filter.copyWith(continent: 'Asia'));
                }),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ── Recent Searches ──
          if (recentSearches.isNotEmpty && recipes.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Searches',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: recentSearches.map((s) {
                      return ActionChip(
                        label: Text(s),
                        avatar: const Icon(Icons.history, size: 16),
                        onPressed: () {
                          _searchController.text = s;
                          _search(s);
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

          // ── Results ──
          Expanded(
            child: provider.isLoading
                ? _buildLoading()
                : recipes.isEmpty
                ? const EmptyStateWidget(
                    icon: Icons.search_off_rounded,
                    title: 'No recipes found',
                    subtitle: 'Try adjusting your search or filters',
                  )
                : AnimationLimiter(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemCount: recipes.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 350),
                          child: SlideAnimation(
                            verticalOffset: 30,
                            child: FadeInAnimation(
                              child: RecipeCard(
                                recipe: recipes[index],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RecipeDetailScreen(
                                        recipe: recipes[index],
                                      ),
                                    ),
                                  );
                                },
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

  Widget _quickChip(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(label, style: const TextStyle(fontSize: 12)),
        onPressed: onTap,
        visualDensity: VisualDensity.compact,
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
        SizedBox(height: 14),
        ShimmerBox(height: 200),
      ],
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const FilterBottomSheet(),
    );
  }
}
