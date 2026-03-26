import 'dart:ui';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class ValidAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ValidAppBar({
    super.key,
    this.titleText,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
  }) : assert(
         titleText == null || titleWidget == null,
         'Cannot provide both titleText and titleWidget',
       );

  final String? titleText;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.70),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
          ),
          child: AppBar(
            automaticallyImplyLeading: automaticallyImplyLeading,
            title: titleWidget ?? (titleText != null ? Text(titleText!) : null),
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            iconTheme: const IconThemeData(color: AppColors.primary),
            actionsIconTheme: const IconThemeData(color: AppColors.primary),
            titleTextStyle: const TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            leading: leading,
            actions: actions,
          ),
        ),
      ),
    );
  }
}
