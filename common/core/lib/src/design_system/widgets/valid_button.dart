import 'package:flutter/material.dart';

import 'package:glassmorphism/glassmorphism.dart';
import '../colors/app_colors.dart';

enum ValidButtonVariant { primary, secondary }

enum ValidButtonSize { regular, small }

class ValidButton extends StatelessWidget {
  const ValidButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ValidButtonVariant.primary,
    this.size = ValidButtonSize.regular,
    this.isLoading = false,
    this.width = double.infinity,
    this.icon,
    this.color,
  });

  final String label;
  final VoidCallback? onPressed;
  final ValidButtonVariant variant;
  final ValidButtonSize size;
  final bool isLoading;
  final double width;
  final dynamic icon;
  final Color? color;

  bool get _isPrimary => variant == ValidButtonVariant.primary;
  bool get _isSmall => size == ValidButtonSize.small;

  double get _height => _isSmall ? 36 : 52;
  double get _borderRadius => _isSmall ? 10 : 16;
  double get _fontSize => _isSmall ? 13 : 15;
  double get _iconSize => _isSmall ? 15 : 18;
  double get _loaderSize => _isSmall ? 16 : 22;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    return SizedBox(
      width: width,
      height: _height,
      child: _isPrimary
          ? _PrimaryButton(
              label: label,
              onPressed: isDisabled ? null : onPressed,
              isLoading: isLoading,
              icon: icon,
              color: color,
              height: _height,
              borderRadius: _borderRadius,
              fontSize: _fontSize,
              iconSize: _iconSize,
              loaderSize: _loaderSize,
            )
          : _SecondaryButton(
              label: label,
              onPressed: isDisabled ? null : onPressed,
              isLoading: isLoading,
              icon: icon,
              color: color,
              borderRadius: _borderRadius,
              fontSize: _fontSize,
              iconSize: _iconSize,
              loaderSize: _loaderSize,
            ),
    );
  }
}

// ─── Primary (glass effect) ──────────────────────────────────────────────────

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.onPressed,
    required this.isLoading,
    required this.height,
    required this.borderRadius,
    required this.fontSize,
    required this.iconSize,
    required this.loaderSize,
    this.icon,
    this.color,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final dynamic icon;
  final Color? color;
  final double height;
  final double borderRadius;
  final double fontSize;
  final double iconSize;
  final double loaderSize;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;
    final hasCustomColor = color != null;

    final baseAlpha1 = isDisabled ? 0.1 : (hasCustomColor ? 0.65 : 0.2);
    final baseAlpha2 = isDisabled ? 0.05 : (hasCustomColor ? 0.35 : 0.1);

    final gradientColor1 =
        hasCustomColor ? color! : Colors.black;
    final gradientColor2 =
        hasCustomColor ? color! : Colors.white;

    final contentColor = hasCustomColor ? Colors.white : AppColors.primary;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius),
      splashColor: (hasCustomColor ? color! : Colors.black).withValues(
        alpha: 0.1,
      ),
      highlightColor: (hasCustomColor ? color! : Colors.black).withValues(
        alpha: 0.05,
      ),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: height,
        borderRadius: borderRadius,
        blur: 20,
        alignment: Alignment.center,
        border: 1.5,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            gradientColor1.withValues(alpha: baseAlpha1),
            gradientColor2.withValues(alpha: baseAlpha2),
          ],
          stops: const [0.1, 1],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: isDisabled ? 0.2 : 0.5),
            (hasCustomColor ? color! : Colors.black).withValues(
              alpha: isDisabled ? 0.1 : 0.2,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: _ButtonContent(
            label: label,
            isLoading: isLoading,
            icon: icon,
            color: contentColor,
            fontSize: fontSize,
            iconSize: iconSize,
            loaderSize: loaderSize,
          ),
        ),
      ),
    );
  }
}

// ─── Secondary (outlined) ────────────────────────────────────────────────────

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.label,
    required this.onPressed,
    required this.isLoading,
    required this.borderRadius,
    required this.fontSize,
    required this.iconSize,
    required this.loaderSize,
    this.icon,
    this.color,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final dynamic icon;
  final Color? color;
  final double borderRadius;
  final double fontSize;
  final double iconSize;
  final double loaderSize;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;
    final effectiveColor =
        isDisabled ? AppColors.textSecondary : (color ?? AppColors.primary);

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: effectiveColor,
        backgroundColor: Colors.transparent,
        side: const BorderSide(color: Colors.transparent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.zero,
      ),
      child: _ButtonContent(
        label: label,
        isLoading: isLoading,
        icon: icon,
        color: effectiveColor,
        fontSize: fontSize,
        iconSize: iconSize,
        loaderSize: loaderSize,
      ),
    );
  }
}

// ─── Shared content ──────────────────────────────────────────────────────────

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.isLoading,
    required this.color,
    required this.fontSize,
    required this.iconSize,
    required this.loaderSize,
    this.icon,
  });

  final String label;
  final bool isLoading;
  final Color color;
  final dynamic icon;
  final double fontSize;
  final double iconSize;
  final double loaderSize;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: loaderSize,
          height: loaderSize,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          (icon is IconData)
              ? Icon(icon, size: iconSize, color: color)
              : SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: icon as Widget,
                ),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: color,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
