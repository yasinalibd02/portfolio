import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 600;

    return Scaffold(
      appBar: isMobile ? AppBar(title: const Text('Yasin Ali')) : null,
      drawer: isMobile
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Text(
                      'Menu',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  _buildDrawerItem(context, 'Home', '/'),
                  _buildDrawerItem(context, 'About', '/about'),
                  _buildDrawerItem(context, 'Projects', '/projects'),
                  _buildDrawerItem(context, 'Blog', '/blog'),
                  _buildDrawerItem(context, 'Contact', '/contact'),
                ],
              ),
            )
          : null,
      body: isMobile
          ? navigationShell
          : Column(
              children: [
                _DesktopNavbar(navigationShell: navigationShell),
                Expanded(child: navigationShell),
              ],
            ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String label, String route) {
    return ListTile(
      title: Text(label),
      onTap: () {
        context.go(route);
        Navigator.pop(context); // Close drawer
      },
    );
  }
}

class _DesktopNavbar extends StatelessWidget {
  const _DesktopNavbar({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          Text(
            "Yasin Ali",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          _NavBarItem(
            label: 'Home',
            index: 0,
            navigationShell: navigationShell,
          ),
          _NavBarItem(
            label: 'About',
            index: 1,
            navigationShell: navigationShell,
          ),
          _NavBarItem(
            label: 'Projects',
            index: 2,
            navigationShell: navigationShell,
          ),
          _NavBarItem(
            label: 'Blog',
            index: 3,
            navigationShell: navigationShell,
          ),
          _NavBarItem(
            label: 'Contact',
            index: 4,
            navigationShell: navigationShell,
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.label,
    required this.index,
    required this.navigationShell,
  });

  final String label;
  final int index;
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final isSelected = navigationShell.currentIndex == index;
    return InkWell(
      onTap: () => navigationShell.goBranch(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
