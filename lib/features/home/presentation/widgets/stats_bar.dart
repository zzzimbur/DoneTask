import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';

class StatsBar extends StatelessWidget {
  final int activeCount;
  final int todayCount;
  final double totalBudget;

  const StatsBar({
    super.key,
    required this.activeCount,
    required this.todayCount,
    required this.totalBudget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      margin: const EdgeInsets.only(top: AppConstants.spacingMd, bottom: AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMd),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            value: '$activeCount',
            label: 'активных',
          ),
          Container(
            width: 1,
            height: 24,
            color: AppColors.divider,
          ),
          _StatItem(
            value: '$todayCount',
            label: 'сегодня',
          ),
          Container(
            width: 1,
            height: 24,
            color: AppColors.divider,
          ),
          _StatItem(
            value: _formatBudget(totalBudget),
            label: 'бюджет',
          ),
        ],
      ),
    );
  }

  String _formatBudget(double budget) {
    if (budget >= 1000000) {
      return '₽${(budget / 1000000).toStringAsFixed(1)}M';
    } else if (budget >= 1000) {
      return '₽${(budget / 1000).toStringAsFixed(1)}K';
    }
    return '₽${budget.toStringAsFixed(0)}';
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}