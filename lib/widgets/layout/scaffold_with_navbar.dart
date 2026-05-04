import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ScaffoldWithNavbar extends StatefulWidget {
  const ScaffoldWithNavbar({required this.navigationShell, super.key});
  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithNavbar> createState() => _ScaffoldWithNavbarState();
}

class _ScaffoldWithNavbarState extends State<ScaffoldWithNavbar> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isMobile ? _buildDrawer(context) : null,
      appBar: isMobile ? _buildMobileAppBar(context) : null,
      // Floating SMS/WhatsApp button
      floatingActionButton: _WhatsAppFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: isMobile
          ? widget.navigationShell
          : Stack(
              children: [
                Positioned.fill(child: widget.navigationShell),
                _DesktopNavbar(navigationShell: widget.navigationShell),
              ],
            ),
    );
  }

  PreferredSizeWidget _buildMobileAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface.withOpacity(0.95),
      elevation: 0,
      title: _LogoWidget(),
      leading: Builder(
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [AppColors.accent, Color(0xFF005F35)],
                    ),
                    boxShadow: [
                      BoxShadow(color: AppColors.accentGlow, blurRadius: 16),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Yasin Ali',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  'Flutter Developer',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppColors.border,
            margin: const EdgeInsets.symmetric(horizontal: 24),
          ),
          const SizedBox(height: 8),
          ..._navItems.map(
            (item) => _DrawerNavItem(
              label: item.label,
              index: item.index,
              isSelected: widget.navigationShell.currentIndex == item.index,
              onTap: () {
                context.go(item.route);
                Navigator.pop(context);
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: _SMSButton(fullWidth: true),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────
// Floating WhatsApp / SMS button
// ─────────────────────────────────────
class _WhatsAppFAB extends StatefulWidget {
  @override
  State<_WhatsAppFAB> createState() => _WhatsAppFABState();
}

class _WhatsAppFABState extends State<_WhatsAppFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _ring;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: false);
    _ring = Tween<double>(
      begin: 1.0,
      end: 1.6,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ring,
      builder: (_, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Ripple ring
            Container(
              width: 56 * _ring.value,
              height: 56 * _ring.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withOpacity(
                  (1.4 - _ring.value).clamp(0, 0.25),
                ),
              ),
            ),
            child!,
          ],
        );
      },
      child: GestureDetector(
        onTap: () async {
          const url = 'https://wa.me/8801308985262';
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.accent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.accentGlow,
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.chat_rounded,
            color: AppColors.background,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class _SMSButton extends StatelessWidget {
  const _SMSButton({this.fullWidth = false});
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse('sms:+8801308985262');
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.accent.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.sms_rounded, color: AppColors.accent, size: 18),
            SizedBox(width: 8),
            Text(
              'Send SMS',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────
// Desktop Navbar
// ─────────────────────────────────────
class _DesktopNavbar extends StatelessWidget {
  const _DesktopNavbar({required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: AppColors.background.withOpacity(0.80),
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Row(
              children: [
                _LogoWidget(),
                const Spacer(),
                ..._navItems.map(
                  (item) => _NavLink(
                    label: item.label,
                    index: item.index,
                    navigationShell: navigationShell,
                  ),
                ),
                const SizedBox(width: 20),
                _LetsTalkBtn(onTap: () => navigationShell.goBranch(4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppColors.accent, Color(0xFF004D2C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [BoxShadow(color: AppColors.accentGlow, blurRadius: 10)],
          ),
          child: const CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
        ),
        const SizedBox(width: 11),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Yasin Ali',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 14.5,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              'Flutter Developer',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────
// Nav link with animated underline
// ─────────────────────────────────────
class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.label,
    required this.index,
    required this.navigationShell,
  });
  final String label;
  final int index;
  final StatefulNavigationShell navigationShell;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.navigationShell.currentIndex == widget.index;
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.navigationShell.goBranch(widget.index),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: active
                      ? AppColors.accent
                      : _h
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 13.5,
                ),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: 200.ms,
                height: 2,
                width: active ? 18 : 0,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(color: AppColors.accentGlow, blurRadius: 6),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LetsTalkBtn extends StatefulWidget {
  const _LetsTalkBtn({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_LetsTalkBtn> createState() => _LetsTalkBtnState();
}

class _LetsTalkBtnState extends State<_LetsTalkBtn> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: 200.ms,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          decoration: BoxDecoration(
            color: _h ? AppColors.accent : Colors.transparent,
            border: Border.all(color: _h ? AppColors.accent : AppColors.border),
            borderRadius: BorderRadius.circular(50),
            boxShadow: _h
                ? [BoxShadow(color: AppColors.accentGlow, blurRadius: 16)]
                : [],
          ),
          child: Text(
            "Let's Talk",
            style: TextStyle(
              color: _h ? AppColors.background : AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
        ),
      ),
    );
  }
}



// ─────────────────────────────────────
// Drawer nav item
// ─────────────────────────────────────
class _DrawerNavItem extends StatelessWidget {
  const _DrawerNavItem({
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });
  final String label;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accent.withOpacity(0.07)
              : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isSelected ? AppColors.accent : Colors.transparent,
              width: 2.5,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.accent : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 15.5,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────
// Nav data
// ─────────────────────────────────────
class _NavItemData {
  final String label, route;
  final int index;
  const _NavItemData(this.label, this.route, this.index);
}

const _navItems = [
  _NavItemData('Home', '/', 0),
  _NavItemData('About', '/about', 1),
  _NavItemData('Projects', '/projects', 2),
  _NavItemData('Blog', '/blog', 3),
  _NavItemData('Contact', '/contact', 4),
];
