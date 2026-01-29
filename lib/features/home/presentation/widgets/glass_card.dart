import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../../../core/theme/colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final bool isDarkMode;

  const GlassCard({
    super.key,
    required this.child,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = isDarkMode 
        ? Colors.white.withOpacity(0.05) 
        : Colors.black.withOpacity(0.02);
    final borderColor = isDarkMode 
        ? Colors.white.withOpacity(0.1) 
        : Colors.black.withOpacity(0.04);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor,
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode 
                  ? Colors.black.withOpacity(0.2) 
                  : Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }
}