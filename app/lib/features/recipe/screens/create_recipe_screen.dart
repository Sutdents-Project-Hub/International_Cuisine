import 'package:api_client/api_client.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/premium_widgets.dart';
import '../providers/recipe_provider.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 4;

  // Form State
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _cookTimeController = TextEditingController();
  final _servingsController = TextEditingController(text: '2');
  final _caloriesController = TextEditingController();

  String _difficulty = 'BEGINNER';
  final String _country = 'Italy'; // Default for MVP
  // Draft Lists
  final List<IngredientDtoBuilder> _ingredients = [];
  final List<StepDtoBuilder> _steps = [];

  bool _isSubmitting = false;

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.dispose();
    _descController.dispose();
    _prepTimeController.dispose();
    _cookTimeController.dispose();
    _servingsController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize with one empty ingredient and step
    _addIngredient();
    _addStep();
  }

  void _addIngredient() {
    setState(() {
      _ingredients.add(
        IngredientDtoBuilder()
          ..name = ''
          ..qtyPerServing = 1
          ..unit = 'pc',
      );
    });
  }

  void _addStep() {
    setState(() {
      _steps.add(
        StepDtoBuilder()
          ..description = ''
          ..order = _steps.length + 1,
      );
    });
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    } else {
      _submitRecipe();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep--);
    }
  }

  Future<void> _submitRecipe() async {
    if (!_formKey.currentState!.validate()) return;
    if (_ingredients.isEmpty || _steps.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add ingredients and steps')),
      );
      return;
    }

    // Validate content of ingredients and steps
    for (final ing in _ingredients) {
      if (ing.name == null ||
          ing.name!.trim().isEmpty ||
          (ing.qtyPerServing ?? 0) <= 0 ||
          ing.unit == null ||
          ing.unit!.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please check ingredient details (name, quantity and unit)',
            ),
          ),
        );
        return;
      }
    }

    for (final step in _steps) {
      if (step.description == null || step.description!.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please check step descriptions')),
        );
        return;
      }
    }

    setState(() => _isSubmitting = true);

    try {
      // Re-index steps to ensure sequential order
      for (var i = 0; i < _steps.length; i++) {
        _steps[i].order = i + 1;
      }

      final dto = CreateRecipeDto(
        (b) => b
          ..title = _titleController.text
          ..culturalNote = _descController
              .text // Using desc as cultural note for now
          ..difficulty = CreateRecipeDtoDifficultyEnum.valueOf(_difficulty)
          ..prepTimeMinutes = int.tryParse(_prepTimeController.text) ?? 0
          ..cookTimeMinutes = int.tryParse(_cookTimeController.text) ?? 0
          ..totalTimeMinutes =
              (int.tryParse(_prepTimeController.text) ?? 0) +
              (int.tryParse(_cookTimeController.text) ?? 0)
          ..servingsBase = int.tryParse(_servingsController.text) ?? 1
          ..caloriesPerServing = int.tryParse(_caloriesController.text) ?? 0
          ..country = _country
          ..ingredients.replace(_ingredients.map((e) => e.build()))
          ..steps.replace(_steps.map((e) => e.build())),
      );

      debugPrint('Submitting Recipe DTO: $dto');

      final success = await context.read<RecipeProvider>().createRecipe(dto);

      if (mounted) {
        setState(() => _isSubmitting = false);
        if (success) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Recipe created successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to create recipe')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1A1A1A), Color(0xFF0D0D0D)],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildStep1Basics(),
                        _buildStep2Ingredients(),
                        _buildStep3Steps(),
                        _buildStep4Review(),
                      ],
                    ),
                  ),
                  _buildBottomBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const Expanded(
                child: Text(
                  'Create Recipe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 48), // Balance back button
            ],
          ),
          const SizedBox(height: 16),
          // Progress Indicator
          Row(
            children: List.generate(_totalSteps, (index) {
              final isActive = index <= _currentStep;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : Colors.grey[800],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            'Step ${_currentStep + 1} of $_totalSteps',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return GlassCard(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            TextButton(
              onPressed: _prevStep,
              child: const Text('Back', style: TextStyle(color: Colors.grey)),
            )
          else
            const SizedBox(width: 60),

          GradientButton(
            label: _currentStep == _totalSteps - 1 ? 'Publish' : 'Next',
            onPressed: _nextStep,
            isLoading: _isSubmitting,
            width: 140,
          ),
        ],
      ),
    );
  }

  Widget _buildStep1Basics() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputLabel('Title'),
          _buildTextField(
            _titleController,
            'Recipe Name',
            Icons.restaurant_menu,
          ),
          const SizedBox(height: 20),
          _buildInputLabel('Description / Note'),
          _buildTextField(
            _descController,
            'Brief description',
            Icons.description,
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputLabel('Prep Time (min)'),
                    _buildTextField(
                      _prepTimeController,
                      '15',
                      Icons.timer,
                      isNumber: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputLabel('Cook Time (min)'),
                    _buildTextField(
                      _cookTimeController,
                      '20',
                      Icons.timer_outlined,
                      isNumber: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputLabel('Servings'),
                    _buildTextField(
                      _servingsController,
                      '2',
                      Icons.people,
                      isNumber: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputLabel('Calories/Serv'),
                    _buildTextField(
                      _caloriesController,
                      '500',
                      Icons.local_fire_department,
                      isNumber: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInputLabel('Difficulty'),
          const SizedBox(height: 8),
          _buildDifficultySelector(),
        ],
      ),
    );
  }

  Widget _buildStep2Ingredients() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ..._ingredients.asMap().entries.map((entry) {
              final index = entry.key;
              final ingredient = entry.value;
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: GlassCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    initialValue: ingredient.name,
                                    onChanged: (val) => ingredient.name = val,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration('Ingredient'),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () => setState(
                                    () => _ingredients.removeAt(index),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: ingredient.qtyPerServing
                                        .toString(),
                                    onChanged: (val) =>
                                        ingredient.qtyPerServing =
                                            num.tryParse(val) ?? 0,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration('Qty'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: ingredient.unit,
                                    onChanged: (val) => ingredient.unit = val,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration(
                                      'Unit (g, ml)',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            GradientButton(
              label: 'Add Ingredient',
              icon: Icons.add,
              onPressed: _addIngredient,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep3Steps() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ..._steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: GlassCard(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                initialValue: step.description,
                                onChanged: (val) => step.description = val,
                                maxLines: 3,
                                style: const TextStyle(color: Colors.white),
                                decoration: _inputDecoration(
                                  'Describe this step...',
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.grey),
                              onPressed: () =>
                                  setState(() => _steps.removeAt(index)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            GradientButton(
              label: 'Add Step',
              icon: Icons.add,
              onPressed: _addStep,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep4Review() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 80,
            color: AppColors.primary,
          ),
          const SizedBox(height: 20),
          const Text(
            'Ready to Publish!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Review your recipe details below',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 30),
          GlassCard(
            child: Column(
              children: [
                _buildReviewRow('Title', _titleController.text),
                const Divider(color: Colors.white10),
                _buildReviewRow(
                  'Time',
                  '${int.tryParse(_prepTimeController.text) ?? 0} + ${int.tryParse(_cookTimeController.text) ?? 0} min',
                ),
                const Divider(color: Colors.white10),
                _buildReviewRow('Ingredients', '${_ingredients.length} items'),
                const Divider(color: Colors.white10),
                _buildReviewRow('Steps', '${_steps.length} steps'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        label,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool isNumber = false,
    int maxLines = 1,
  }) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          icon: Icon(icon, color: AppColors.primary, size: 20),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[600]),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDifficultySelector() {
    return Row(
      children: ['BEGINNER', 'INTERMEDIATE', 'ADVANCED'].map((level) {
        final isSelected = _difficulty == level;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _difficulty = level),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.black26,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.white12,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                level[0] + level.substring(1).toLowerCase(),
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
      border: InputBorder.none,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
    );
  }
}
