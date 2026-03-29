import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/premium_widgets.dart';
import '../../cooking/screens/cooking_mode_screen.dart';
import '../../favorites/providers/favorites_provider.dart';
import '../../shopping_list/providers/shopping_list_provider.dart';
import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  final String? heroTag;

  const RecipeDetailScreen({super.key, required this.recipe, this.heroTag});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  late Recipe _recipe;
  int _servings = 1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe;
    _servings = _recipe.servingsBase;
    _tabCtrl = TabController(length: 3, vsync: this);
    _loadRecipe();
  }

  Future<void> _loadRecipe() async {
    final provider = context.read<RecipeProvider>();
    final fullRecipe = await provider.getRecipe(_recipe.id);
    if (mounted && fullRecipe != null) {
      setState(() {
        _recipe = fullRecipe;
        _isLoading = false;
        if (_recipe.servingsBase > 0) {
          _servings = _recipe.servingsBase;
        }
      });
    } else {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  double _scaledQty(double original) {
    if (_recipe.servingsBase == 0) return original;
    return original * _servings / _recipe.servingsBase;
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<FavoritesProvider>();
    final isFav = favProvider.isFavorite(_recipe.id);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          // ── Parallax Hero Header ──
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            backgroundColor: AppColors.background,
            leading: _circleButton(
              icon: Icons.arrow_back_rounded,
              onTap: () => Navigator.pop(context),
            ),
            actions: [
              _circleButton(
                icon: isFav
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: isFav ? AppColors.error : null,
                onTap: () => favProvider.toggleFavorite(_recipe.id),
              ),
              _circleButton(
                icon: Icons.share_rounded,
                onTap: () => SharePlus.instance.share(
                  ShareParams(text: 'Check out this recipe: ${_recipe.title}'),
                ),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: widget.heroTag ?? 'recipe-image-${_recipe.id}',
                    child: _recipe.imageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: _recipe.imageUrl!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/placeholder_recipe.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                  // Gradient overlay
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0x88000000),
                          Color(0xCC121212),
                        ],
                        stops: [0.3, 0.7, 1.0],
                      ),
                    ),
                  ),
                  // Bottom info
                  Positioned(
                    bottom: 16,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DifficultyBadge(difficulty: _recipe.difficulty),
                        const SizedBox(height: 8),
                        Text(
                          _recipe.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${_recipe.country}${_recipe.city != null ? ', ${_recipe.city}' : ''}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            // ── Stats Row ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                children: [
                  _statItem(
                    Icons.access_time_rounded,
                    '${_recipe.totalTimeMinutes}',
                    'min',
                  ),
                  _statItem(
                    Icons.local_fire_department_outlined,
                    '${_recipe.caloriesPerServing}',
                    'cal',
                  ),
                  _statItem(
                    Icons.people_outline_rounded,
                    '$_servings',
                    'servings',
                  ),
                  if (_recipe.ratingAvg > 0)
                    _statItem(
                      Icons.star_rounded,
                      _recipe.ratingAvg.toStringAsFixed(1),
                      'rating',
                    ),
                ],
              ),
            ),

            // ── Serving Adjuster ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Servings',
                    style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _servings > 1
                        ? () => setState(() => _servings--)
                        : null,
                    icon: const Icon(Icons.remove_circle_outline_rounded),
                    iconSize: 22,
                    color: AppColors.primary,
                  ),
                  Text(
                    '$_servings',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _servings++),
                    icon: const Icon(Icons.add_circle_outline_rounded),
                    iconSize: 22,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),

            // ── Tab Bar ──
            TabBar(
              controller: _tabCtrl,
              tabs: const [
                Tab(text: 'Ingredients'),
                Tab(text: 'Steps'),
                Tab(text: 'Info'),
              ],
            ),

            // ── Tab Views ──
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                      controller: _tabCtrl,
                      children: [
                        _buildIngredients(),
                        _buildSteps(),
                        _buildInfo(),
                      ],
                    ),
            ),
          ],
        ),
      ),

      // ── Bottom Action Bar ──
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _addToShoppingList,
                  icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                  label: const Text('Add to List'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: GradientButton(
                  label: 'Start Cooking',
                  icon: Icons.restaurant_rounded,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CookingModeScreen(recipe: _recipe),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIngredients() {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: _recipe.ingredients.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final ing = _recipe.ingredients[index];
        final qty = _scaledQty(ing.qtyPerServing);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  ing.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Text(
                '${qty.toStringAsFixed(qty == qty.roundToDouble() ? 0 : 1)} ${ing.unit}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSteps() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _recipe.steps.length,
      itemBuilder: (context, index) {
        final step = _recipe.steps[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  gradient: AppColors.heroGradient,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
                    if (step.defaultTimerSeconds != null &&
                        step.defaultTimerSeconds! > 0) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.info.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.info.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              size: 14,
                              color: AppColors.info,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${(step.defaultTimerSeconds! / 60).ceil()} min',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.info,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfo() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        if (_recipe.culturalNote != null &&
            _recipe.culturalNote!.isNotEmpty) ...[
          const Text(
            'Cultural Note',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          GlassCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.auto_stories_rounded,
                  color: AppColors.secondary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _recipe.culturalNote!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
        if (_recipe.cuisineTags.isNotEmpty) ...[
          const Text(
            'Tags',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _recipe.cuisineTags.map((tag) {
              return Chip(
                label: Text(tag),
                visualDensity: VisualDensity.compact,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
        // Stats grid
        Row(
          children: [
            Expanded(
              child: AnimatedStatChip(
                icon: Icons.visibility_outlined,
                label: 'Views',
                value: '${_recipe.viewCount}',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AnimatedStatChip(
                icon: Icons.thumb_up_outlined,
                label: 'Likes',
                value: '${_recipe.likeCount}',
                color: AppColors.error,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AnimatedStatChip(
                icon: Icons.check_circle_outline,
                label: 'Completed',
                value: '${_recipe.completedCount}',
                color: AppColors.success,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _addToShoppingList() {
    final slp = context.read<ShoppingListProvider>();
    slp.createList(_recipe.title, [_recipe.id], [_servings]);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Added to shopping list!'),
        action: SnackBarAction(
          label: 'View',
          textColor: AppColors.primary,
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: color ?? AppColors.textPrimary),
        ),
      ),
    );
  }

  Widget _statItem(IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
