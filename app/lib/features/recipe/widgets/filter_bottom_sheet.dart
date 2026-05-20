import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/recipe_filter.dart';
import '../providers/recipe_provider.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late RecipeFilter _filter;
  final TextEditingController _maxIngredientsController =
      TextEditingController();
  final TextEditingController _maxCaloriesController = TextEditingController();

  final List<String> _difficulties = const [
    'BEGINNER',
    'INTERMEDIATE',
    'ADVANCED',
  ];
  final List<String> _diets = const [
    'vegetarian',
    'vegan',
    'gluten-free',
    'keto',
  ];
  final List<String> _methods = const ['fry', 'bake', 'steam', 'boil', 'stew'];

  @override
  void initState() {
    super.initState();
    _filter = context.read<RecipeProvider>().filter.copyWith();
    _maxIngredientsController.text = _filter.maxIngredients?.toString() ?? '';
    _maxCaloriesController.text = _filter.maxCalories?.toString() ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeProvider>().fetchCountries();
    });
  }

  @override
  void dispose() {
    _maxIngredientsController.dispose();
    _maxCaloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<RecipeProvider>();

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Recipes',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF8C00),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            _buildLabel('Continent'),
            Builder(
              builder: (_) {
                final continents = provider.countriesByContinent.keys.toList();
                final validContinent = continents.contains(_filter.continent)
                    ? _filter.continent
                    : null;
                return DropdownButtonFormField<String?>(
                  key: ValueKey('continent_${continents.length}'),
                  initialValue: validContinent,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All Continents'),
                    ),
                    ...continents.map(
                      (c) => DropdownMenuItem(value: c, child: Text(c)),
                    ),
                  ],
                  onChanged: (value) => setState(() {
                    _filter.continent = value;
                    _filter.country =
                        null; // reset country when continent changes
                  }),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildLabel('Country'),
            Builder(
              builder: (_) {
                final countries = _filter.continent != null
                    ? (provider.countriesByContinent[_filter.continent] ?? [])
                    : provider.countries;
                final validCountry = countries.contains(_filter.country)
                    ? _filter.country
                    : null;
                return DropdownButtonFormField<String?>(
                  key: ValueKey(
                    'country_${_filter.continent}_${countries.length}',
                  ),
                  initialValue: validCountry,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All Countries'),
                    ),
                    ...countries.map(
                      (c) => DropdownMenuItem(value: c, child: Text(c)),
                    ),
                  ],
                  onChanged: (value) => setState(() => _filter.country = value),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildLabel('Difficulty'),
            Wrap(
              spacing: 8,
              children: _difficulties
                  .map((difficulty) {
                    final selected = _filter.difficulty == difficulty;
                    return ChoiceChip(
                      label: Text(difficulty),
                      selected: selected,
                      onSelected: (_) {
                        setState(() {
                          _filter.difficulty = selected ? null : difficulty;
                        });
                      },
                    );
                  })
                  .toList(growable: false),
            ),
            const SizedBox(height: 12),
            _buildLabel('Diet'),
            Wrap(
              spacing: 8,
              children: _diets
                  .map((diet) {
                    final selected = _filter.diet == diet;
                    return ChoiceChip(
                      label: Text(diet),
                      selected: selected,
                      onSelected: (_) {
                        setState(() {
                          _filter.diet = selected ? null : diet;
                        });
                      },
                    );
                  })
                  .toList(growable: false),
            ),
            const SizedBox(height: 12),
            _buildLabel('Cooking Method'),
            Wrap(
              spacing: 8,
              children: _methods
                  .map((method) {
                    final selected = _filter.cookingMethod == method;
                    return ChoiceChip(
                      label: Text(method),
                      selected: selected,
                      onSelected: (_) {
                        setState(() {
                          _filter.cookingMethod = selected ? null : method;
                        });
                      },
                    );
                  })
                  .toList(growable: false),
            ),
            const SizedBox(height: 12),
            _buildLabel('Max Time: ${_filter.maxTime ?? 'Any'} min'),
            Slider(
              min: 10,
              max: 180,
              divisions: 17,
              value: (_filter.maxTime ?? 180).toDouble(),
              label: (_filter.maxTime ?? 180).toString(),
              onChanged: (value) =>
                  setState(() => _filter.maxTime = value.toInt()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _maxIngredientsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Max ingredients count',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _maxCaloriesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Max calories'),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Show hidden recipes'),
              value: _filter.showHidden,
              onChanged: (value) => setState(() => _filter.showHidden = value),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<RecipeProvider>().clearFilter();
                      Navigator.pop(context);
                    },
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _filter.maxIngredients = int.tryParse(
                        _maxIngredientsController.text,
                      );
                      _filter.maxCalories = int.tryParse(
                        _maxCaloriesController.text,
                      );
                      context.read<RecipeProvider>().updateFilter(_filter);
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
