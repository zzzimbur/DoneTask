// ============================================================================
// ФАЙЛ: SEARCH BAR WIDGET - ПОИСКОВАЯ СТРОКА
// ============================================================================
// ОТВЕЧАЕТ ЗА: Отображение поискового поля с иконкой и кнопкой очистки
// ============================================================================

import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';

class SearchBarWidget extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;

  const SearchBarWidget({
    super.key,
    this.hint = 'Поиск...',
    required this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMd,
        vertical: AppConstants.spacingSm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLg),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          if (onClear != null)
            InkWell(
              onTap: onClear,
              child: const Padding(
                padding: EdgeInsets.all(AppConstants.spacingSm),
                child: Icon(
                  Icons.clear,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}