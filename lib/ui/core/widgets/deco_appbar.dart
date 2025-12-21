import 'package:flutter/material.dart';

class DecoAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool gradientBackground;
  final double height;

  const DecoAppbar({super.key,
  this.title,
  this.leading,
  this.actions,
  this.gradientBackground = true,
  this.height = kToolbarHeight});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final titleStyle = theme.textTheme.titleLarge?.copyWith(
      color: colorScheme.onSurface,
      fontWeight: FontWeight.w700,
    );

    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      foregroundColor: colorScheme.onSurface,
    );
    return const Placeholder();
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
