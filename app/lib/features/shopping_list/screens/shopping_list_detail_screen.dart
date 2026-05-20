import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/premium_widgets.dart';
import '../models/shopping_list.dart';
import '../providers/shopping_list_provider.dart';

class ShoppingListDetailScreen extends StatelessWidget {
  final ShoppingList list;

  const ShoppingListDetailScreen({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ShoppingListProvider>();
    // Refresh from provider if available
    final current =
        provider.lists.where((l) => l.id == list.id).firstOrNull ?? list;
    final items = current.items;

    // Group by category
    final grouped = <String, List<ShoppingListItem>>{};
    for (final item in items) {
      (grouped[item.category] ??= []).add(item);
    }
    final categories = grouped.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: Text(current.title),
        actions: [
          IconButton(
            onPressed: () => _copyToClipboard(context, current),
            icon: const Icon(Icons.copy_rounded, size: 20),
            tooltip: 'Copy list',
          ),
        ],
      ),
      body: items.isEmpty
          ? const EmptyStateWidget(
              icon: Icons.checklist_rounded,
              title: 'No items',
              subtitle: 'This list is empty',
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: categories.length,
              itemBuilder: (context, catIndex) {
                final category = categories[catIndex];
                final catItems = grouped[category]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (catIndex > 0) const SizedBox(height: 16),
                    // Category header
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _categoryColor(category),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatCategory(category),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _categoryColor(category),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 0.5,
                            color: AppColors.divider,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Items
                    ...catItems.map(
                      (item) => _buildItem(context, provider, current, item),
                    ),
                  ],
                );
              },
            ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    ShoppingListProvider provider,
    ShoppingList current,
    ShoppingListItem item,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => provider.toggleItem(current.id, item.id),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: item.checked
                ? AppColors.success.withValues(alpha: 0.06)
                : AppColors.surfaceVariant.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: item.checked
                  ? AppColors.success.withValues(alpha: 0.2)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: item.checked ? AppColors.success : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: item.checked
                        ? AppColors.success
                        : AppColors.textMuted,
                    width: 1.5,
                  ),
                ),
                child: item.checked
                    ? const Icon(
                        Icons.check_rounded,
                        size: 14,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.ingredientName,
                  style: TextStyle(
                    fontSize: 14,
                    color: item.checked
                        ? AppColors.textMuted
                        : AppColors.textPrimary,
                    decoration: item.checked
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
              ),
              if (item.quantity > 0)
                Text(
                  '${item.quantity.toStringAsFixed(item.quantity == item.quantity.roundToDouble() ? 0 : 1)} ${item.unit}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: item.checked
                        ? AppColors.textMuted
                        : AppColors.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, ShoppingList list) {
    final text = list.items
        .map(
          (i) =>
              '${i.checked ? '✓' : '○'} ${i.ingredientName} - ${i.quantity} ${i.unit}',
        )
        .join('\n');
    Clipboard.setData(ClipboardData(text: '${list.title}\n\n$text'));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Copied to clipboard!')));
  }

  Color _categoryColor(String category) {
    switch (category.toUpperCase()) {
      case 'PRODUCE':
        return AppColors.success;
      case 'DAIRY':
        return AppColors.info;
      case 'MEAT' || 'PROTEIN':
        return AppColors.error;
      case 'SPICES' || 'SEASONING':
        return AppColors.secondary;
      case 'GRAINS' || 'PANTRY':
        return AppColors.warning;
      default:
        return AppColors.textMuted;
    }
  }

  String _formatCategory(String category) {
    return category
        .split('_')
        .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
        .join(' ');
  }
}
