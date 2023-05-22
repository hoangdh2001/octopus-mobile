import 'package:flutter/material.dart';

/// Neumorphic button
class NeumorphicButton extends StatelessWidget {
  /// Constructor for creating [NeumorphicButton]
  const NeumorphicButton({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.size = 40,
  });

  /// Child contained in the button
  final Widget child;

  /// Background color of button
  final Color backgroundColor;

  final double size;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(8),
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade700,
              offset: const Offset(0, 1),
              blurRadius: 0.5,
            ),
            const BoxShadow(
              color: Colors.white,
              blurRadius: 0.5,
            ),
          ],
        ),
        child: child,
      );
}
