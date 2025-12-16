import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FramePage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const FramePage({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.map), label: 'course'),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'calendar',
          ),
          NavigationDestination(icon: Icon(Icons.login), label: 'mypage'),
        ],
      ),
    );
  }
}
