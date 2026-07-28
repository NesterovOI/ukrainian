import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ukrainian/core/theme/app_colors.dart';
import 'package:ukrainian/core/theme/app_dimensions.dart';

/// 3D-кнопка в стилі Neobrutalism
class Neobrutal3DButton extends StatefulWidget {
  final VoidCallback? onTap;
  final Widget child;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? disabledBackgroundColor;
  final Color? disabledShadowColor;
  final double height;
  final double shadowHeight;
  final double borderRadius;
  final bool isEnabled;

  const Neobrutal3DButton({
    super.key,
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.shadowColor,
    this.disabledBackgroundColor,
    this.disabledShadowColor,
    this.height = AppDimensions.buttonHeight,
    this.shadowHeight = AppDimensions.buttonShadowHeight,
    this.borderRadius = AppDimensions.radiusM,
    this.isEnabled = true,
  });

  @override
  State<Neobrutal3DButton> createState() => _Neobrutal3DButtonState();
}

class _Neobrutal3DButtonState extends State<Neobrutal3DButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isEnabled || widget.onTap == null) return;
    HapticFeedback.lightImpact();
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isEnabled || widget.onTap == null) return;
    _releaseButton();
  }

  void _handleTapCancel() {
    if (!widget.isEnabled || widget.onTap == null) return;
    _releaseButton();
  }

  void _releaseButton() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool active = widget.isEnabled && widget.onTap != null;

    final currentBgColor = active
        ? (widget.backgroundColor ?? AppColors.primary)
        : (widget.disabledBackgroundColor ?? AppColors.disabled);

    final currentShadowColor = active
        ? (widget.shadowColor ?? AppColors.primaryShadow)
        : (widget.disabledShadowColor ?? AppColors.disabledShadow);

    final double topOffset = _isPressed ? widget.shadowHeight : 0.0;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: active ? widget.onTap : null,
      child: SizedBox(
        height: widget.height + widget.shadowHeight,
        child: Stack(
          children: [
            // 1. Нижня 3D грань (Основа кнопки)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: widget.height,
                decoration: BoxDecoration(
                  color: currentShadowColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
              ),
            ),
            // 2. Верхня плашка кнопки
            AnimatedPositioned(
              duration: const Duration(milliseconds: 60),
              curve: Curves.easeIn,
              top: topOffset,
              left: 0,
              right: 0,
              child: Container(
                height: widget.height,
                decoration: BoxDecoration(
                  color: currentBgColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    color: active ? Colors.black.withValues(alpha: 0.08) : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceM),
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}