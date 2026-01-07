import 'package:deco/ui/core/ui/deco_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FramePage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const FramePage({super.key, required this.navigationShell});

  @override
  State<FramePage> createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  bool _bearIsPink = true;

  void _onTap(int index) {
    setState(() {
      _bearIsPink = !_bearIsPink;
    });

    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: DecoBottomNavbar(
        currentIndex: widget.navigationShell.currentIndex,
        bearIsPink: _bearIsPink,
        onTap: _onTap,
      ),
    );
  }
}
