import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/premium_widgets.dart';
import '../../recipe/models/recipe.dart';
import '../providers/cooking_provider.dart';

class CookingModeScreen extends StatefulWidget {
  final Recipe recipe;

  const CookingModeScreen({super.key, required this.recipe});

  @override
  State<CookingModeScreen> createState() => _CookingModeScreenState();
}

class _CookingModeScreenState extends State<CookingModeScreen> {
  late PageController _pageController;
  late CookingProvider _cookingProvider;
  int _currentStep = 0;

  List<RecipeStep> get steps => widget.recipe.steps;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _cookingProvider = context.read<CookingProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (steps.isNotEmpty) {
        _cookingProvider.speakStep(steps[0].description);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _cookingProvider.stopTimer(notify: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cooking = context.watch<CookingProvider>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.recipe.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          // TTS toggle
          IconButton(
            onPressed: () => cooking.toggleTts(!cooking.ttsEnabled),
            icon: Icon(
              cooking.ttsEnabled
                  ? Icons.volume_up_rounded
                  : Icons.volume_off_rounded,
              color: cooking.ttsEnabled
                  ? AppColors.primary
                  : AppColors.textMuted,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Step Progress Dots ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(steps.length + 1, (i) {
                final isActive = i == _currentStep;
                final isDone = i < _currentStep;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: isActive ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary
                        : isDone
                        ? AppColors.success
                        : AppColors.divider,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),

          // ── Step Label ──
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              _currentStep < steps.length
                  ? 'Step ${_currentStep + 1} of ${steps.length}'
                  : 'Done!',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // ── Page View ──
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: steps.length + 1,
              onPageChanged: (index) {
                setState(() => _currentStep = index);
                cooking.stopTimer();
                if (index < steps.length) {
                  cooking.speakStep(steps[index].description);
                }
              },
              itemBuilder: (context, index) {
                if (index == steps.length) {
                  return _buildCompletionPage();
                }
                return _buildStepPage(steps[index], index, cooking);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepPage(RecipeStep step, int index, CookingProvider cooking) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // ── Timer ──
          if (step.defaultTimerSeconds != null &&
              step.defaultTimerSeconds! > 0) ...[
            const SizedBox(height: 8),
            _buildCircularTimer(cooking, step.defaultTimerSeconds!),
            const SizedBox(height: 20),
          ] else
            const SizedBox(height: 24),

          // ── Step Description ──
          Expanded(
            child: GlassCard(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: SingleChildScrollView(
                  child: Text(
                    step.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.textPrimary,
                      height: 1.7,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ── Nav Buttons ──
          Row(
            children: [
              if (index > 0)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    icon: const Icon(Icons.arrow_back_rounded, size: 18),
                    label: const Text('Previous'),
                  ),
                ),
              if (index > 0) const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: GradientButton(
                  label: index < steps.length - 1 ? 'Next Step' : 'Complete!',
                  icon: index < steps.length - 1
                      ? Icons.arrow_forward_rounded
                      : Icons.check_rounded,
                  onPressed: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildCircularTimer(CookingProvider cooking, int totalSeconds) {
    final remaining = cooking.secondsRemaining;
    final progress = cooking.isTimerRunning ? remaining / totalSeconds : 1.0;

    return GestureDetector(
      onTap: () {
        if (cooking.isTimerRunning) {
          cooking.stopTimer();
        } else {
          cooking.startTimer(totalSeconds);
        }
      },
      child: SizedBox(
        width: 120,
        height: 120,
        child: CustomPaint(
          painter: _TimerPainter(
            progress: progress.clamp(0.0, 1.0),
            color: cooking.isTimerRunning
                ? AppColors.primary
                : AppColors.textMuted,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  cooking.isTimerRunning
                      ? '${(remaining ~/ 60).toString().padLeft(2, '0')}:${(remaining % 60).toString().padLeft(2, '0')}'
                      : '${(totalSeconds ~/ 60).toString().padLeft(2, '0')}:${(totalSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: cooking.isTimerRunning
                        ? AppColors.primary
                        : AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  cooking.isTimerRunning ? 'Tap to stop' : 'Tap to start',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: AppColors.heroGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: 24,
                ),
              ],
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 48,
              color: AppColors.textOnPrimary,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Recipe Complete!',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Great job, Chef! You\'ve mastered another dish.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          GradientButton(
            label: 'Back to Recipe',
            icon: Icons.arrow_back_rounded,
            onPressed: () => Navigator.pop(context),
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

// ── Timer Arc Painter ──
class _TimerPainter extends CustomPainter {
  final double progress;
  final Color color;

  _TimerPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;

    // Background track
    final bgPaint = Paint()
      ..color = AppColors.divider
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimerPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
