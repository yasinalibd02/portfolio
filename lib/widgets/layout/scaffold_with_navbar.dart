import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Stack(
        children: [
          Positioned.fill(child: widget.navigationShell),
          if (!isMobile)
            _DesktopNavbar(navigationShell: widget.navigationShell),
          // Techven Top Accent Progress Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 2.5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF4795B),
                    Color(0xFFF25C3B),
                    Color(0xFFFFB59E),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x66F4795B),
                    blurRadius: 8,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
            ),
          ),
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
          icon: Icon(Icons.menu_rounded, color: AppColors.textPrimary),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
        ),
      ),
      actions: const [
        Padding(padding: EdgeInsets.only(right: 12), child: ThemeToggle()),
      ],
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
                    gradient: LinearGradient(
                      colors: [AppColors.accent, AppColors.accentDeep],
                    ),
                    boxShadow: [
                      BoxShadow(color: AppColors.accentGlow, blurRadius: 16),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.accent,
                        alignment: Alignment.center,
                        child: Text(
                          'YA',
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'MD Yasin Ali',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Full Stack Developer',
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
    const waColor = Color(0xFF25D366);

    return AnimatedBuilder(
      animation: _ring,
      builder: (_, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Ripple ring
            Container(
              width: 58 * _ring.value,
              height: 58 * _ring.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: waColor.withOpacity(
                  (1.4 - _ring.value).clamp(0.0, 0.28),
                ),
              ),
            ),
            child!,
          ],
        );
      },
      child: Tooltip(
        message: 'Chat on WhatsApp',
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              const url = 'https://wa.me/8801308985262';
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            },
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: waColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: waColor.withOpacity(0.45),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
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
          children: [
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
                const ThemeToggle(),
                const SizedBox(width: 12),
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
            gradient: LinearGradient(
              colors: [AppColors.accent, AppColors.accentDeep],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [BoxShadow(color: AppColors.accentGlow, blurRadius: 10)],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/profile.png',
              width: 33,
              height: 33,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.accent,
                alignment: Alignment.center,
                child: Text(
                  'YA',
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 11),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yasin Ali',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 15,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              'Digital Solutions & Apps',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.accent,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
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
                height: 2.5,
                width: active ? 22 : (_h ? 12 : 0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF4795B), Color(0xFFF25C3B)],
                  ),
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

// ─────────────────────────────────────
// Light / dark toggle
// ─────────────────────────────────────
class ThemeToggle extends StatefulWidget {
  const ThemeToggle({super.key});

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final dark = ThemeController.isDark;
    return Tooltip(
      message: dark ? 'Switch to light mode' : 'Switch to dark mode',
      child: MouseRegion(
        onEnter: (_) => setState(() => _h = true),
        onExit: (_) => setState(() => _h = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: ThemeController.toggle,
          child: AnimatedContainer(
            duration: 200.ms,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _h ? AppColors.accent.withOpacity(0.12) : AppColors.surfaceCard,
              shape: BoxShape.circle,
              border: Border.all(
                color: _h ? AppColors.accent.withOpacity(0.45) : AppColors.border,
              ),
            ),
            child: AnimatedSwitcher(
              duration: 300.ms,
              transitionBuilder: (child, anim) => RotationTransition(
                turns: Tween(begin: 0.75, end: 1.0).animate(anim),
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: Icon(
                dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                key: ValueKey(dark),
                size: 18,
                color: _h ? AppColors.accent : AppColors.textPrimary,
              ),
            ),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _h
                  ? [AppColors.accentDark, AppColors.accentDeep]
                  : [AppColors.accent, AppColors.accentDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentGlow,
                blurRadius: _h ? 18 : 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Let's Talk",
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 14,
              ),
            ],
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
