import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/premium_widgets.dart';
import '../../recipe/providers/recipe_provider.dart';
import '../../recipe/widgets/recipe_card.dart';
import '../../recipe/screens/recipe_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String? _selectedContinent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final rp = context.read<RecipeProvider>();
      if (rp.recipes.isEmpty) rp.fetchRecipes();
    });
  }

  static const _continentIcons = {
    'Asia': Icons.temple_buddhist_rounded,
    'Europe': Icons.castle_rounded,
    'Africa': Icons.terrain_rounded,
    'North America': Icons.landscape_rounded,
    'South America': Icons.forest_rounded,
    'Oceania': Icons.water_rounded,
  };

  static const _continentEmoji = {
    'Asia': '🏯',
    'Europe': '🏰',
    'Africa': '🌍',
    'North America': '🗽',
    'South America': '🌿',
    'Oceania': '🌊',
  };

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipeProvider>();
    final continentMap = provider.countriesByContinent;
    final continents = continentMap.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        actions: [
          if (_selectedContinent != null)
            IconButton(
              onPressed: () => setState(() => _selectedContinent = null),
              icon: const Icon(Icons.close_rounded),
              tooltip: 'Back to all regions',
            ),
        ],
      ),
      body: provider.isLoading
          ? _buildLoading()
          : _selectedContinent == null
          ? _buildContinentGrid(continents, continentMap)
          : _buildCountryRecipes(provider),
    );
  }

  Widget _buildContinentGrid(
    List<String> continents,
    Map<String, List<String>> continentMap,
  ) {
    if (continents.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.public_off_rounded,
        title: 'No regions available',
        subtitle: 'Recipes will appear here once loaded',
      );
    }

    return AnimationLimiter(
      child: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.1,
        ),
        itemCount: continents.length,
        itemBuilder: (context, index) {
          final continent = continents[index];
          final countries = continentMap[continent] ?? [];
          final color = AppColors.continentColor(continent);
          final icon = _continentIcons[continent] ?? Icons.public;
          final emoji = _continentEmoji[continent] ?? '🌎';

          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 2,
            duration: const Duration(milliseconds: 400),
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedContinent = continent),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          color.withValues(alpha: 0.2),
                          color.withValues(alpha: 0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: color.withValues(alpha: 0.3)),
                    ),
                    child: Stack(
                      children: [
                        // Background emoji
                        Positioned(
                          right: -8,
                          bottom: -8,
                          child: Text(
                            emoji,
                            style: TextStyle(
                              fontSize: 60,
                              color: color.withValues(alpha: 0.15),
                            ),
                          ),
                        ),
                        // Content
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(icon, color: color, size: 24),
                              ),
                              const Spacer(),
                              Text(
                                continent,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: color,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${countries.length} ${countries.length == 1 ? 'country' : 'countries'}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: color.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCountryRecipes(RecipeProvider provider) {
    // Derive which countries belong to the selected continent
    final continentCountries =
        provider.countriesByContinent[_selectedContinent] ?? [];
    final allowedCountries = continentCountries.toSet();
    final recipes = provider.recipes
        .where((r) => allowedCountries.contains(r.country))
        .toList();

    final countries = recipes.map((r) => r.country).toSet().toList()..sort();
    final color = AppColors.continentColor(_selectedContinent!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _continentIcons[_selectedContinent] ?? Icons.public,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedContinent!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    '${recipes.length} recipes · ${countries.length} countries',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Country chips
        if (countries.isNotEmpty)
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              itemCount: countries.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return ActionChip(
                  label: Text(countries[index]),
                  backgroundColor: color.withValues(alpha: 0.08),
                  side: BorderSide(color: color.withValues(alpha: 0.2)),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                  onPressed: () {
                    provider.updateFilter(
                      provider.filter.copyWith(country: countries[index]),
                    );
                  },
                );
              },
            ),
          ),

        // Recipe list
        Expanded(
          child: recipes.isEmpty
              ? const EmptyStateWidget(
                  icon: Icons.restaurant_menu_rounded,
                  title: 'No recipes found',
                  subtitle: 'Try exploring a different region',
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
    );
  }

  Widget _buildLoading() {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      children: List.generate(
        6,
        (_) => const ShimmerBox(height: 150, borderRadius: 20),
      ),
    );
  }
}
