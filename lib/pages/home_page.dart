import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/theme.dart';
import 'package:portfolio/widgets/live_web_platforms_section.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 700;
    return SingleChildScrollView(
      child: Column(
        children: [
          _HeroSection(isMobile: isMobile),
          const LiveWebPlatformsSection(),
          const _PublishedAppsSection(),
          _TechStackMarquee(),
          _StatsBar(),
          _AboutSection(),
          _SkillsSection(),
          _ServicesSection(),
          _CareerJourneySection(),
          _FooterStrip(),
        ],
      ),
    );
  }
}


// ──────────────────────────────────────────────────────────
// HERO
// ──────────────────────────────────────────────────────────
// ──────────────────────────────────────────────────────────
// TECHVEN HERO SECTION (MATCHING SCREENSHOT 1:1)
// ──────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.isMobile});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final showFloatingChips = width >= 960;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // 48px Grid backdrop
        Positioned.fill(
          child: ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (rect) => const RadialGradient(
              center: Alignment(0, -0.2),
              radius: 0.95,
              colors: [Colors.white, Colors.transparent],
            ).createShader(rect),
            child: CustomPaint(
              painter: _GridPainter(color: AppColors.gridLine),
            ),
          ),
        ),

        // Ambient coral glow blobs (matching Techven .blob)
        _GlowBlob(
          dx: -0.05,
          dy: 0.1,
          size: 440,
          color: const Color(0xFFF4795B).withOpacity(0.24),
        ),
        _GlowBlob(
          dx: 0.95,
          dy: 0.7,
          size: 460,
          color: const Color(0xFFF4795B).withOpacity(0.18),
        ),

        // Faint concentric background orbits (fx-orbit)
        Positioned(
          top: 60,
          child: Container(
            width: 580,
            height: 580,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accent.withOpacity(0.06),
                width: 1,
              ),
            ),
          ),
        ),
        Positioned(
          top: 150,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.secondaryAccent.withOpacity(0.04),
                width: 1,
              ),
            ),
          ),
        ),

        // ── 4 FLOATING SIDE CHIPS ON DESKTOP (.fx-chip) ──
        // ── 4 FLOATING SIDE CHIPS ON DESKTOP (.fx-chip) ──
        if (showFloatingChips) ...[
          // Top-Left: Web (top: 24%, left: ~4%)
          Positioned(
            top: 150,
            left: (width * 0.05).clamp(20.0, 100.0),
            child: const _FxChip(
              icon: Icons.language_rounded,
              label: 'Web',
              bobDurationMs: 6500,
              delayMs: 0,
            ),
          ),

          // Bottom-Left: App (top: 64%, left: ~7%)
          Positioned(
            top: 360,
            left: (width * 0.07).clamp(24.0, 120.0),
            child: const _FxChip(
              icon: Icons.smartphone_rounded,
              label: 'App',
              bobDurationMs: 7500,
              delayMs: 1500,
            ),
          ),

          // Top-Right: SaaS (top: 28%, right: ~6%)
          Positioned(
            top: 165,
            right: (width * 0.06).clamp(20.0, 110.0),
            child: const _FxChip(
              icon: Icons.cloud_outlined,
              label: 'SaaS',
              bobDurationMs: 7000,
              delayMs: 3000,
            ),
          ),

          // Bottom-Right: Automation (top: 66%, right: ~5%)
          Positioned(
            top: 375,
            right: (width * 0.05).clamp(20.0, 100.0),
            child: const _FxChip(
              icon: Icons.auto_awesome_rounded,
              label: 'Automation',
              bobDurationMs: 8000,
              delayMs: 4500,
            ),
          ),
        ],

        // ── CENTER CONTENT ──
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            isMobile ? 20 : 40,
            isMobile ? 100 : 135,
            isMobile ? 20 : 40,
            isMobile ? 16 : 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Badge: Ready to Build and Scale Beyond Borders?
              const _Badge().animate().fadeIn(duration: 600.ms).slideY(begin: -.2),

              SizedBox(height: isMobile ? 20 : 28),

              // Headline: Helping Brands Build and Grow [Digital Products] That Scale Globally
              _TechvenHeadline(isMobile: isMobile)
                  .animate()
                  .fadeIn(delay: 150.ms, duration: 700.ms)
                  .slideY(begin: 0.15, end: 0),

              SizedBox(height: isMobile ? 18 : 26),

              // Subtitle paragraph
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 820),
                child: Text(
                  "Full Stack Developer with 4+ years of experience engineering mobile applications, web platforms, SaaS products, and AI-powered automation workflows. Delivering high-impact digital solutions across fintech, e-commerce, healthcare, and SaaS.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: isMobile ? 15 : 17.5,
                    height: 1.65,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ).animate().fadeIn(delay: 300.ms),

              SizedBox(height: isMobile ? 26 : 36),

              // Two CTA buttons: Start Your Project & Download Resume
              Wrap(
                spacing: 16,
                runSpacing: 14,
                alignment: WrapAlignment.center,
                children: [
                  _TechvenPrimaryBtn(
                    label: 'Start Your Project',
                    icon: Icons.rocket_launch_rounded,
                    onTap: (ctx) => ctx.go('/contact'),
                  ),
                  _TechvenSecondaryBtn(
                    label: 'Download Resume',
                    icon: Icons.download_rounded,
                    onTap: (ctx) async {
                      final uri = Uri.parse('resume.pdf');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      } else {
                        await launchUrl(
                          Uri.parse('assets/assets/MD_Yasin_Ali_Full_Stack_Developer.pdf'),
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                  ),
                ],
              ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.1, end: 0),

              SizedBox(height: isMobile ? 18 : 22),

              // Social Icons Row
              const _HeroSocialIcons()
                  .animate()
                  .fadeIn(delay: 500.ms)
                  .slideY(begin: 0.1, end: 0),

              // On mobile / smaller screens, display the 4 chips in a clean wrap
              if (!showFloatingChips) ...[
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: const [
                    _FxChipInline(icon: Icons.language_rounded, label: 'Web'),
                    _FxChipInline(icon: Icons.smartphone_rounded, label: 'App'),
                    _FxChipInline(icon: Icons.cloud_outlined, label: 'SaaS'),
                    _FxChipInline(icon: Icons.auto_awesome_rounded, label: 'Automation'),
                  ],
                ).animate().fadeIn(delay: 550.ms),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────
// HEADLINE WITH ROTATING WORD & BLINKING CARET
// ──────────────────────────────────────────────────────────
class _TechvenHeadline extends StatelessWidget {
  const _TechvenHeadline({required this.isMobile});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 640) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Helping Brands Build & Grow',
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textPrimary,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              height: 1.12,
              letterSpacing: -1.2,
            ),
          ),
          const SizedBox(height: 6),
          const _HeroRotator(fontSize: 36),
          const SizedBox(height: 6),
          Text(
            'That Scale Globally',
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textPrimary,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              height: 1.12,
              letterSpacing: -1.2,
            ),
          ),
        ],
      );
    }

    final fontSize = width > 1100 ? 66.0 : 50.0;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 940),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Helping Brands Build and',
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textPrimary,
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              height: 1.05,
              letterSpacing: -2.0,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Grow ',
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textPrimary,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w800,
                  height: 1.05,
                  letterSpacing: -2.0,
                ),
              ),
              _HeroRotator(fontSize: fontSize),
              Text(
                ' That',
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textPrimary,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w800,
                  height: 1.05,
                  letterSpacing: -2.0,
                ),
              ),
            ],
          ),
          Text(
            'Scale Globally',
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textPrimary,
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              height: 1.05,
              letterSpacing: -2.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroRotator extends StatefulWidget {
  const _HeroRotator({required this.fontSize});
  final double fontSize;

  @override
  State<_HeroRotator> createState() => _HeroRotatorState();
}

class _HeroRotatorState extends State<_HeroRotator> {
  static const _words = [
    'Digital Products',
    'Mobile Apps',
    'Web Platforms',
    'SaaS Products',
    'AI Workflows',
    'FinTech Solutions',
  ];

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _loop();
  }

  void _loop() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 2800));
      if (!mounted) break;
      setState(() {
        _index = (_index + 1) % _words.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFF4795B), Color(0xFFF25C3B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, anim) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.4),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: Text(
              _words[_index],
              key: ValueKey<int>(_index),
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w800,
                height: 1.05,
                letterSpacing: -2.0,
              ),
            ),
          ),
        ),
        _CaretCursor(fontSize: widget.fontSize),
      ],
    );
  }
}

class _CaretCursor extends StatefulWidget {
  const _CaretCursor({required this.fontSize});
  final double fontSize;

  @override
  State<_CaretCursor> createState() => _CaretCursorState();
}

class _CaretCursorState extends State<_CaretCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _ctrl,
      child: Container(
        width: 3.5,
        height: widget.fontSize * 0.72,
        margin: const EdgeInsets.only(left: 4),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF4795B), Color(0xFFF25C3B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// FLOATING SIDE CHIP (.fx-chip)
// ──────────────────────────────────────────────────────────
class _FxChip extends StatefulWidget {
  const _FxChip({
    required this.icon,
    required this.label,
    required this.bobDurationMs,
    required this.delayMs,
  });

  final IconData icon;
  final String label;
  final int bobDurationMs;
  final int delayMs;

  @override
  State<_FxChip> createState() => _FxChipState();
}

class _FxChipState extends State<_FxChip> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _transAnim;
  late Animation<double> _rotAnim;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.bobDurationMs),
    );

    _transAnim = Tween<double>(begin: 0, end: -16).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );

    _rotAnim = Tween<double>(begin: -0.025, end: 0.025).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );

    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _ctrl.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeController.isDark;

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _hovered ? -4 : _transAnim.value),
          child: Transform.rotate(
            angle: _hovered ? 0 : _rotAnim.value,
            child: child,
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          decoration: BoxDecoration(
            color: _hovered
                ? (dark
                    ? const Color(0xFFF4795B).withOpacity(0.22)
                    : const Color(0xFFFFF1EE))
                : (dark
                    ? AppColors.surfaceCard.withOpacity(0.95)
                    : Colors.white.withOpacity(0.98)),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? const Color(0xFFF4795B).withOpacity(0.85)
                  : AppColors.border,
              width: _hovered ? 1.5 : 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF4795B).withOpacity(_hovered ? 0.35 : 0.06),
                blurRadius: _hovered ? 26 : 14,
                offset: Offset(0, _hovered ? 8 : 4),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(dark ? 0.35 : 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 19,
                color: const Color(0xFFF4795B),
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: GoogleFonts.spaceGrotesk(
                  color: _hovered
                      ? const Color(0xFFF4795B)
                      : AppColors.textPrimary,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FxChipInline extends StatefulWidget {
  const _FxChipInline({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  State<_FxChipInline> createState() => _FxChipInlineState();
}

class _FxChipInlineState extends State<_FxChipInline> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final dark = ThemeController.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: _hovered
              ? (dark
                  ? const Color(0xFFF4795B).withOpacity(0.22)
                  : const Color(0xFFFFF1EE))
              : (dark
                  ? AppColors.surfaceCard.withOpacity(0.95)
                  : Colors.white.withOpacity(0.98)),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovered
                ? const Color(0xFFF4795B).withOpacity(0.85)
                : AppColors.border,
            width: _hovered ? 1.4 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF4795B).withOpacity(_hovered ? 0.28 : 0.04),
              blurRadius: _hovered ? 16 : 8,
              offset: Offset(0, _hovered ? 4 : 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: 16,
              color: const Color(0xFFF4795B),
            ),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: GoogleFonts.spaceGrotesk(
                color: _hovered
                    ? const Color(0xFFF4795B)
                    : AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _GridPainter extends CustomPainter {
  const _GridPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const step = 48.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => old.color != color;
}

// Glow blob in background
class _GlowBlob extends StatelessWidget {
  const _GlowBlob({
    required this.dx,
    required this.dy,
    required this.size,
    this.color,
  });
  final double dx, dy, size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = 700.0;
    return Positioned(
      left: dx * w - size / 2,
      top: dy * h - size / 2,
      child:
          Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      (color ?? AppColors.accent).withOpacity(0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.15, 1.15),
                duration: 4.seconds,
                curve: Curves.easeInOut,
              )
              .slide(
                begin: const Offset(-0.02, -0.02),
                end: const Offset(0.02, 0.02),
                duration: 5.seconds,
                curve: Curves.easeInOut,
              ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge();

  @override
  Widget build(BuildContext context) {
    final dark = ThemeController.isDark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: BoxDecoration(
        color: dark
            ? const Color(0xFFF4795B).withOpacity(0.12)
            : const Color(0xFFF4795B).withOpacity(0.08),
        border: Border.all(
          color: const Color(0xFFF4795B).withOpacity(0.35),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF4795B).withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _PulsingDot(),
          const SizedBox(width: 9),
          Text(
            'Full Stack Developer · Available for Hire & Projects',
            style: GoogleFonts.spaceGrotesk(
              color: const Color(0xFFF4795B),
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  const _PulsingDot();

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _scale = Tween<double>(
      begin: 0.7,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Color(0xFFF4795B),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// TECHVEN CTA BUTTONS
// ──────────────────────────────────────────────────────────
class _TechvenPrimaryBtn extends StatefulWidget {
  const _TechvenPrimaryBtn({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final void Function(BuildContext) onTap;

  @override
  State<_TechvenPrimaryBtn> createState() => _TechvenPrimaryBtnState();
}

class _TechvenPrimaryBtnState extends State<_TechvenPrimaryBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onTap(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..translate(0.0, _hovered ? -3.0 : 0.0),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFF4795B), Color(0xFFF25C3B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF4795B).withOpacity(_hovered ? 0.45 : 0.30),
                blurRadius: _hovered ? 26 : 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(width: 8),
              Icon(widget.icon, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechvenSecondaryBtn extends StatefulWidget {
  const _TechvenSecondaryBtn({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final void Function(BuildContext) onTap;

  @override
  State<_TechvenSecondaryBtn> createState() => _TechvenSecondaryBtnState();
}

class _TechvenSecondaryBtnState extends State<_TechvenSecondaryBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final dark = ThemeController.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onTap(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..translate(0.0, _hovered ? -3.0 : 0.0),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
          decoration: BoxDecoration(
            color: _hovered
                ? (dark ? Colors.white.withOpacity(0.10) : Colors.white)
                : (dark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.92)),
            border: Border.all(
              color: _hovered
                  ? const Color(0xFFF4795B).withOpacity(0.6)
                  : AppColors.border,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(dark ? 0.25 : 0.04),
                blurRadius: _hovered ? 16 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(width: 8),
              Icon(widget.icon, color: AppColors.textPrimary, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// HERO & FOOTER SOCIAL ICONS
// ──────────────────────────────────────────────────────────
class _HeroSocialIcons extends StatelessWidget {
  const _HeroSocialIcons();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: const [
        _HeroSocialBtn(
          icon: FontAwesomeIcons.github,
          tooltip: 'GitHub',
          url: 'https://github.com/yasinalibd02',
          hoverColor: Color(0xFF6E5494),
        ),
        _HeroSocialBtn(
          icon: FontAwesomeIcons.linkedin,
          tooltip: 'LinkedIn',
          url: 'https://www.linkedin.com/in/yasinalibd02',
          hoverColor: Color(0xFF0A66C2),
        ),
        _HeroSocialBtn(
          icon: FontAwesomeIcons.whatsapp,
          tooltip: 'WhatsApp',
          url: 'https://wa.me/8801308985262',
          hoverColor: Color(0xFF25D366),
        ),
        _HeroSocialBtn(
          icon: FontAwesomeIcons.twitter,
          tooltip: 'X (Twitter)',
          url: 'https://x.com/YasinAl99967413',
          hoverColor: Color(0xFF1DA1F2),
        ),
        _HeroSocialBtn(
          icon: FontAwesomeIcons.envelope,
          tooltip: 'Email',
          url: 'mailto:yasinali.dev@gmail.com',
          hoverColor: Color(0xFFEA4335),
        ),
      ],
    );
  }
}

class _HeroSocialBtn extends StatefulWidget {
  const _HeroSocialBtn({
    required this.icon,
    required this.tooltip,
    required this.url,
    required this.hoverColor,
  });

  final FaIconData icon;
  final String tooltip;
  final String url;
  final Color hoverColor;

  @override
  State<_HeroSocialBtn> createState() => _HeroSocialBtnState();
}

class _HeroSocialBtnState extends State<_HeroSocialBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final dark = ThemeController.isDark;

    return Tooltip(
      message: widget.tooltip,
      waitDuration: const Duration(milliseconds: 300),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            final uri = Uri.parse(widget.url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            width: 44,
            height: 44,
            transform: Matrix4.identity()..translate(0.0, _hovered ? -3.0 : 0.0),
            decoration: BoxDecoration(
              color: _hovered
                  ? widget.hoverColor.withOpacity(dark ? 0.20 : 0.12)
                  : (dark
                      ? const Color(0xFF161A23)
                      : Colors.white.withOpacity(0.9)),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: _hovered
                    ? widget.hoverColor.withOpacity(0.65)
                    : (dark ? const Color(0xFF262C3A) : const Color(0xFFE2E8F0)),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: _hovered
                      ? widget.hoverColor.withOpacity(0.3)
                      : Colors.black.withOpacity(dark ? 0.2 : 0.04),
                  blurRadius: _hovered ? 14 : 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: FaIcon(
                widget.icon,
                size: 17,
                color: _hovered ? widget.hoverColor : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// PUBLISHED APPS
// ──────────────────────────────────────────────────────────
enum _Store { play, apple }

class _AppData {
  const _AppData({
    required this.name,
    required this.tagline,
    required this.category,
    required this.icon,
    required this.screenshot,
    required this.tint,
    required this.store,
    required this.url,
    this.downloads,
    this.rating,
  });

  final String name, tagline, category, icon, screenshot, url;
  final Color tint;
  final _Store store;
  final String? downloads;
  final String? rating;
}

class _PublishedAppsSection extends StatelessWidget {
  const _PublishedAppsSection();

  static const _apps = [
    _AppData(
      name: 'Islah — দ্বীনি জীবনের সঙ্গী',
      tagline:
          'Ad-free Islamic companion with precise prayer times, Qibla finder and daily routines for Bangladesh.',
      category: 'Lifestyle',
      icon: 'assets/images/apps/islah_icon.png',
      screenshot: 'assets/images/apps/islah_shot.jpg',
      tint: Color(0xFF10876A),
      store: _Store.play,
      url: 'https://play.google.com/store/apps/details?id=com.islahbd.app',
      downloads: '5K+',
      rating: '5.0',
    ),
    _AppData(
      name: 'QRPay — Money Transfer',
      tagline:
          'Send, receive and pay with QR codes. Wallet, top-ups and a full merchant & agent ecosystem.',
      category: 'Finance',
      icon: 'assets/images/apps/qrpay_icon.png',
      screenshot: 'assets/images/apps/qrpay_shot.jpg',
      tint: Color(0xFF2563EB),
      store: _Store.play,
      url:
          'https://play.google.com/store/apps/details?id=net.appdevs.qrpayuser&hl=en',
      downloads: '10K+',
    ),
    _AppData(
      name: 'SenPay User',
      tagline:
          'All-in-one digital wallet — transfer funds, top up balance and use virtual cards securely.',
      category: 'Finance',
      icon: 'assets/images/apps/senpay_icon.png',
      screenshot: 'assets/images/apps/senpay_shot.jpg',
      tint: Color(0xFF3B5BFD),
      store: _Store.apple,
      url: 'https://apps.apple.com/us/app/senpay-user/id6746039031',
    ),
    _AppData(
      name: 'Poisa — Money Tracker',
      tagline:
          'Track income & expenses, set budgets and see clean charts — in English or Bangla, online or offline.',
      category: 'Finance',
      icon: 'assets/images/apps/poisa_icon.png',
      screenshot: 'assets/images/apps/poisa_shot.jpg',
      tint: Color(0xFF22A447),
      store: _Store.play,
      url: 'https://play.google.com/store/apps/details?id=com.kori.moneytracker',
      downloads: '50+',
    ),
    _AppData(
      name: 'Luxora Living',
      tagline:
          'Real-estate platform to discover luxury flats, compare projects and monitor live construction progress.',
      category: 'Real Estate',
      icon: 'assets/images/apps/luxora_icon.png',
      screenshot: 'assets/images/apps/luxora_shot.jpg',
      tint: Color(0xFFC9A24A),
      store: _Store.play,
      url: 'https://play.google.com/store/apps/details?id=com.luxoraliving',
      downloads: '50+',
    ),
    _AppData(
      name: 'AppDevs — FinTech Software',
      tagline:
          'Showcase app for AppDevs, a FinTech company building cutting-edge financial products.',
      category: 'Business',
      icon: 'assets/images/apps/appdevs_icon.png',
      screenshot: 'assets/images/apps/appdevs_shot.jpg',
      tint: Color(0xFF1E88E5),
      store: _Store.play,
      url: 'https://play.google.com/store/apps/details?id=net.appdevs',
      downloads: '100+',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (MediaQuery.sizeOf(context).width > 1200 ? 70 : 36),
        vertical: isMobile ? 40 : 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 2,
                color: AppColors.accent,
                margin: const EdgeInsets.only(right: 10),
              ),
              Text(
                'LIVE ON STORES',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            ],
          ).animate().fadeIn().slideX(),
          const SizedBox(height: 16),
          Wrap(
            spacing: 24,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apps people actually use',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: isMobile ? 30 : 40,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'A selection of production apps I built and shipped — '
                      'live on Google Play and the App Store.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15.5,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              _StoreCountPill(
                play: _apps.where((a) => a.store == _Store.play).length,
                apple: _apps.where((a) => a.store == _Store.apple).length,
              ),
            ],
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final isMobile = w < 700;
              final cols = w > 950 ? 3 : 2;
              final gap = isMobile ? 12.0 : 24.0;
              final cardW = (w - gap * (cols - 1)) / cols;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: _apps.indexed.map((e) {
                  final (i, app) = e;
                  return SizedBox(
                    width: cardW,
                    child: _PublishedAppCard(app: app, isMobile: isMobile),
                  )
                      .animate()
                      .fadeIn(delay: (i * 90).ms, duration: 500.ms)
                      .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic);
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StoreCountPill extends StatelessWidget {
  const _StoreCountPill({required this.play, required this.apple});
  final int play, apple;

  @override
  Widget build(BuildContext context) {
    Widget item(FaIconData icon, String label) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, size: 14, color: AppColors.textPrimary),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          item(FontAwesomeIcons.googlePlay, '$play on Google Play'),
          Container(
            width: 1,
            height: 16,
            color: AppColors.border,
            margin: const EdgeInsets.symmetric(horizontal: 14),
          ),
          item(FontAwesomeIcons.apple, '$apple on App Store'),
        ],
      ),
    );
  }
}

class _PublishedAppCard extends StatefulWidget {
  const _PublishedAppCard({required this.app, this.isMobile = false});
  final _AppData app;
  final bool isMobile;

  @override
  State<_PublishedAppCard> createState() => _PublishedAppCardState();
}

class _PublishedAppCardState extends State<_PublishedAppCard> {
  bool _h = false;

  Future<void> _open() async {
    final uri = Uri.parse(widget.app.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = widget.app;
    final dark = ThemeController.isDark;
    final isMobile = widget.isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _open,
        child: AnimatedContainer(
          duration: 280.ms,
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _h ? -6 : 0, 0),
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(isMobile ? 18 : 24),
            border: Border.all(
              color: _h ? app.tint.withOpacity(0.55) : AppColors.border,
            ),
            boxShadow: [
              BoxShadow(
                color: _h ? app.tint.withOpacity(0.22) : AppColors.shadow,
                blurRadius: _h ? 40 : 20,
                offset: Offset(0, _h ? 18 : 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isMobile ? 17 : 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Showcase: tinted backdrop + phone mockup ──
                SizedBox(
                  height: isMobile ? 160 : 230,
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                app.tint.withOpacity(dark ? 0.35 : 0.22),
                                app.tint.withOpacity(dark ? 0.08 : 0.05),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _DotGridPainter(
                            color: app.tint.withOpacity(dark ? 0.18 : 0.14),
                          ),
                        ),
                      ),
                      // Soft glow behind phone
                      Positioned(
                        right: -40,
                        top: -40,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                app.tint.withOpacity(0.45),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Category chip
                      Positioned(
                        left: isMobile ? 10 : 16,
                        top: isMobile ? 10 : 16,
                        child: _GlassChip(label: app.category),
                      ),
                      // Phone
                      AnimatedPositioned(
                        duration: 350.ms,
                        curve: Curves.easeOutCubic,
                        right: isMobile ? 8 : 24,
                        top: _h
                            ? (isMobile ? 14 : 26)
                            : (isMobile ? 22 : 40),
                        child: AnimatedRotation(
                          duration: 350.ms,
                          curve: Curves.easeOutCubic,
                          turns: _h ? 0 : 0.012,
                          child: Transform.scale(
                            scale: isMobile ? 0.72 : 1.0,
                            alignment: Alignment.topRight,
                            child: _PhoneMockup(image: app.screenshot),
                          ),
                        ),
                      ),
                      // App icon
                      Positioned(
                        left: isMobile ? 12 : 20,
                        bottom: isMobile ? 12 : 20,
                        child: AnimatedScale(
                          duration: 300.ms,
                          scale: _h ? 1.06 : 1,
                          child: Container(
                            width: isMobile ? 44 : 68,
                            height: isMobile ? 44 : 68,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(isMobile ? 12 : 18),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.7),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: app.tint.withOpacity(0.35),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(isMobile ? 10 : 16),
                              child: Image.asset(app.icon, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Body ──
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    isMobile ? 12 : 22,
                    isMobile ? 12 : 20,
                    isMobile ? 12 : 22,
                    isMobile ? 14 : 22,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: isMobile ? 14 : 17,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: isMobile ? 4 : 8),
                      SizedBox(
                        height: isMobile ? 32 : 42,
                        child: Text(
                          app.tagline,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: isMobile ? 11 : 13.5,
                            height: 1.45,
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 10 : 16),
                      Wrap(
                        spacing: isMobile ? 5 : 8,
                        runSpacing: isMobile ? 5 : 8,
                        children: [
                          if (app.rating != null)
                            _MetaChip(
                              icon: Icons.star_rounded,
                              iconColor: const Color(0xFFFFB400),
                              label: app.rating!,
                            ),
                          if (app.downloads != null)
                            _MetaChip(
                              icon: Icons.download_rounded,
                              label: app.downloads!,
                            ),
                          if (!isMobile)
                            _MetaChip(
                              icon: Icons.verified_rounded,
                              iconColor: AppColors.accent,
                              label: 'Live',
                            ),
                        ],
                      ),
                      SizedBox(height: isMobile ? 12 : 18),
                      _StoreBadge(
                        store: app.store,
                        hovered: _h,
                        tint: app.tint,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneMockup extends StatelessWidget {
  const _PhoneMockup({required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 132,
      height: 270,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0F17),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x55000000),
            blurRadius: 30,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}

class _GlassChip extends StatelessWidget {
  const _GlassChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard.withOpacity(0.75),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 9.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label, this.iconColor});
  final IconData icon;
  final String label;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor ?? AppColors.textMuted),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StoreBadge extends StatelessWidget {
  const _StoreBadge({
    required this.store,
    required this.hovered,
    required this.tint,
  });
  final _Store store;
  final bool hovered;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    final isPlay = store == _Store.play;
    final bg = hovered ? tint : AppColors.textPrimary;
    final fg = hovered ? Colors.white : AppColors.background;

    return AnimatedContainer(
      duration: 250.ms,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          FaIcon(
            isPlay ? FontAwesomeIcons.googlePlay : FontAwesomeIcons.apple,
            color: fg,
            size: isPlay ? 18 : 22,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isPlay ? 'GET IT ON' : 'Download on the',
                style: TextStyle(
                  color: fg.withOpacity(0.75),
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                ),
              ),
              Text(
                isPlay ? 'Google Play' : 'App Store',
                style: TextStyle(
                  color: fg,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
            ],
          ),
          const Spacer(),
          AnimatedSlide(
            duration: 250.ms,
            offset: Offset(hovered ? 0.15 : 0, 0),
            child: Icon(Icons.arrow_outward_rounded, color: fg, size: 18),
          ),
        ],
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  const _DotGridPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const step = 18.0;
    for (double y = step / 2; y < size.height; y += step) {
      for (double x = step / 2; x < size.width; x += step) {
        canvas.drawCircle(Offset(x, y), 1.1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotGridPainter old) => old.color != color;
}

// ──────────────────────────────────────────────────────────
// TECH marquee
// ──────────────────────────────────────────────────────────
class _TechStackMarquee extends StatelessWidget {
  static const _techs = [
    'Laravel & PHP',
    'JavaScript & Next.js',
    'Flutter & Dart',
    'MySQL & Databases',
    'n8n Automation',
    'Prompt Engineering',
    'REST APIs & Webhooks',
    'Google Play & App Store',
    'SaaS Architecture',
    'Figma UI/UX',
    'GitHub & CI/CD',
    'Tailwind CSS',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        children: [
          Text(
            'TECHNOLOGIES I WORK WITH',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.5,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: _techs.indexed.map((e) {
              final (i, tech) = e;
              return _TechPill(
                label: tech,
              ).animate().fadeIn(delay: (i * 60).ms).slideY(begin: 0.3, end: 0);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _TechPill extends StatefulWidget {
  const _TechPill({required this.label});
  final String label;

  @override
  State<_TechPill> createState() => _TechPillState();
}

class _TechPillState extends State<_TechPill> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: _h
              ? AppColors.accent.withValues(alpha: 0.10)
              : AppColors.surfaceCard,
          border: Border.all(
            color: _h ? AppColors.accent.withValues(alpha: 0.4) : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: _h ? AppColors.accent : AppColors.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// STATS BAR
// ──────────────────────────────────────────────────────────
class _StatsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const stats = [
      ('4+', 'Years', 'Experience'),
      ('40+', 'Mobile & Web', 'Projects'),
      ('6+', 'Live SaaS &', 'Web Platforms'),
      ('100%', 'Production', 'Deployments'),
    ];

    final isMobile = MediaQuery.sizeOf(context).width < 700;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.04),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
      ),

      child: isMobile
          ? GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.2,
              children: stats
                  .map((s) => _StatItem(num: s.$1, label1: s.$2, label2: s.$3))
                  .toList(),
            )
          : Row(
              children: stats.map((s) {
                final isLast = stats.last == s;
                return Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _StatItem(num: s.$1, label1: s.$2, label2: s.$3),
                      ),
                      if (!isLast)
                        Container(
                          width: 1,
                          height: 40,
                          color: AppColors.border,
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.15, end: 0);
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.num,
    required this.label1,
    required this.label2,
  });
  final String num, label1, label2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          num,
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.accent,
            fontSize: 44,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '$label1 ',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              TextSpan(
                text: label2,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────
// FOOTER STRIP
// ──────────────────────────────────────────────────────────
class _FooterStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      child: Column(
        children: [
          Divider(color: AppColors.border),
          const SizedBox(height: 20),
          const _HeroSocialIcons(),
          const SizedBox(height: 18),
          Text(
            '© 2026 MD Yasin Ali · Full Stack Developer',
            style: TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// ABOUT SECTION
// ──────────────────────────────────────────────────────────
class _AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      child: isMobile
          ? Column(
              children: [
                _buildImage(context),
                const SizedBox(height: 40),
                _buildText(context),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildImage(context)),
                const SizedBox(width: 80),
                Expanded(child: _buildText(context)),
              ],
            ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.1),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset('assets/images/profile.jpeg', fit: BoxFit.cover),
      ),
    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2);
  }

  Widget _buildText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 20,
              height: 2,
              color: AppColors.accent,
              margin: const EdgeInsets.only(right: 10),
            ),
            Text(
              'ABOUT ME',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ],
        ).animate().fadeIn().slideX(),
        const SizedBox(height: 24),
        Text(
          "Full Stack Developer driving scalable digital execution.",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
        const SizedBox(height: 24),
        Text(
          "With 4+ years of experience engineering mobile applications, web platforms, SaaS products, and AI-powered automation workflows, I deliver high-impact digital products from architecture to production. Skilled in Laravel, PHP, JavaScript, Next.js, MySQL, and API integration, with deep expertise in Flutter and Dart.",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
            height: 1.7,
          ),
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
        const SizedBox(height: 20),
        Text(
          "I have contributed to 40+ mobile and web projects across fintech, e-commerce, healthcare, and digital enterprises. Experienced in product development, technical decision-making, App Store and Google Play deployments, and AI automation using n8n and prompt engineering.",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
            height: 1.7,
          ),
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────
// SKILLS SECTION
// ──────────────────────────────────────────────────────────
class _SkillsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 700;

    final skills = [
      ('Flutter & Dart (Mobile)', 0.95),
      ('Laravel & PHP (Backend)', 0.90),
      ('JavaScript & Next.js (Web)', 0.88),
      ('MySQL & REST API Architecture', 0.92),
      ('n8n Automation & AI Workflows', 0.85),
      ('App Store & Google Play Deployment', 0.95),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 2,
                color: AppColors.accent,
                margin: const EdgeInsets.only(right: 10),
              ),
              Text(
                'MY SKILLS',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            ],
          ).animate().fadeIn().slideX(),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isMobile ? 1 : 2;
              final childWidth =
                  (constraints.maxWidth - (crossAxisCount - 1) * 40) /
                  crossAxisCount;

              return Wrap(
                spacing: 40,
                runSpacing: 32,
                children: skills.indexed.map((e) {
                  final (i, skill) = e;
                  return SizedBox(
                    width: childWidth,
                    child: _SkillBar(
                      title: skill.$1,
                      percentage: skill.$2,
                      delay: i * 100,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillBar extends StatelessWidget {
  const _SkillBar({
    required this.title,
    required this.percentage,
    required this.delay,
  });

  final String title;
  final double percentage;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${(percentage * 100).toInt()}%',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 12),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(4),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedContainer(
                    duration: 1000.ms,
                    curve: Curves.easeOutCubic,
                    width: constraints.maxWidth * percentage,
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.accentDark, AppColors.accent],
                      ),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ).animate().scaleX(
                    begin: 0,
                    end: 1,
                    alignment: Alignment.centerLeft,
                    delay: delay.ms + 200.ms,
                    duration: 800.ms,
                    curve: Curves.easeOutCubic,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────
// SERVICES SECTION
// ──────────────────────────────────────────────────────────
class _ServicesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 800;
    
    final services = [
      (
        icon: Icons.phone_android_rounded,
        title: 'Mobile App\nDevelopment',
        desc: 'Cross-platform mobile applications built with Flutter & Dart. End-to-end delivery from pixel-perfect UI to App Store & Google Play deployments.',
        points: ['Flutter & Dart Ecosystem', 'App Store & Google Play', 'API & State Architecture']
      ),
      (
        icon: Icons.cloud_done_rounded,
        title: 'SaaS & Web\nPlatforms',
        desc: 'High-performing web platforms and SaaS solutions built on Laravel, PHP, Next.js, and MySQL. Scalable, secure, and production-ready.',
        points: ['Laravel & Next.js Platforms', 'FinTech & E-Commerce', 'MySQL Database Architecture']
      ),
      (
        icon: Icons.auto_awesome_rounded,
        title: 'AI & Workflow\nAutomation',
        desc: 'Smart business automation and AI agent workflows using n8n and prompt engineering. Connecting APIs, CRM, and multi-channel customer journeys.',
        points: ['n8n Workflow Automation', 'AI Agent Integration', 'Webhooks & Third-Party APIs']
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (isMobile) {
                return Column(
                  children: services.indexed.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _ServiceCard(
                        icon: e.$2.icon,
                        title: e.$2.title,
                        desc: e.$2.desc,
                        points: e.$2.points,
                        delay: e.$1 * 100,
                      ),
                    );
                  }).toList(),
                );
              }
              return Row(
                children: services.indexed.map((e) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: e.$1 < services.length - 1 ? 24 : 0,
                      ),
                      child: _ServiceCard(
                        icon: e.$2.icon,
                        title: e.$2.title,
                        desc: e.$2.desc,
                        points: e.$2.points,
                        delay: e.$1 * 100,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.desc,
    required this.points,
    required this.delay,
  });

  final IconData icon;
  final String title;
  final String desc;
  final List<String> points;
  final int delay;

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _h = false;

  Future<void> _openWhatsApp() async {
    final cleanTitle = widget.title.replaceAll('\n', ' ');
    final message = 'Hello Yasin! I would like to discuss a project regarding $cleanTitle.';
    final url = 'https://wa.me/8801308985262?text=${Uri.encodeComponent(message)}';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: GestureDetector(
        onTap: _openWhatsApp,
        child: AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: _h ? AppColors.surfaceHover : AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _h ? AppColors.accent.withOpacity(0.55) : AppColors.border,
              width: _h ? 1.4 : 1.0,
            ),
            boxShadow: _h
                ? [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.14),
                      blurRadius: 28,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(widget.icon, color: AppColors.textPrimary, size: 24),
              ),
              const SizedBox(height: 32),
              Text(
                widget.title,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.desc,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),
              ...widget.points.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            p,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 32),
              Divider(color: AppColors.border),
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Start Project',
                    style: TextStyle(
                      color: _h ? AppColors.accent : AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: Matrix4.translationValues(_h ? 4.0 : 0.0, 0, 0),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _h
                          ? AppColors.accent.withOpacity(0.15)
                          : AppColors.background,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _h ? AppColors.accent : AppColors.border,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: _h ? AppColors.accent : AppColors.textPrimary,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate().fadeIn(delay: widget.delay.ms).slideY(begin: 0.1, end: 0),
    );
  }
}

// ──────────────────────────────────────────────────────────
// CAREER JOURNEY SECTION
// ──────────────────────────────────────────────────────────
class _CareerJourneySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 800;
    
    final roles = [
      (
        period: '04/2026 - PRESENT',
        title: 'Full Stack Developer',
        company: 'Dhaka, Bangladesh',
        location: 'Dhaka, Bangladesh',
        desc: 'Lead technical execution across mobile applications, web platforms, SaaS products, and AI automation workflows. Contribute to product development, technical decision-making, and product strategy.',
      ),
      (
        period: '05/2023 - 03/2026',
        title: 'Software Developer (Flutter)',
        company: 'AppDevs',
        location: 'Dhaka, Bangladesh',
        desc: 'Managed end-to-end mobile app deployments on the App Store and Google Play at AppDevs. Resolved bugs, implemented client customizations, and collaborated across teams to deliver high-performance apps on schedule.',
      ),
      (
        period: '10/2022 - 04/2023',
        title: 'Jr. Software Developer (Flutter)',
        company: 'Dhaka, Bangladesh',
        location: 'Dhaka, Bangladesh',
        desc: 'Delivered pixel-perfect UI across multiple Flutter projects. Worked on API integrations, connecting mobile apps with backend microservices.',
      ),
      (
        period: '01/2022 - 01/2026',
        title: 'B.Sc in Computer Science & Engineering',
        company: 'Sonargaon University',
        location: 'Dhaka, Bangladesh',
        desc: 'Undergraduate degree focusing on software engineering principles, algorithms, distributed systems, and computer architecture.',
      ),
      (
        period: '07/2017 - 07/2021',
        title: 'Diploma in Computer Technology',
        company: 'Magura Polytechnic Institute',
        location: 'Magura, Bangladesh',
        desc: 'Engineering diploma in computer technology with comprehensive practical training in software fundamentals and network systems.',
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      child: Column(
        children: [
          Text(
            'Career Journey',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 36,
              fontWeight: FontWeight.w800,
            ),
          ).animate().fadeIn().slideY(),
          const SizedBox(height: 12),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.accentDark, AppColors.accent],
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ).animate().scaleX(delay: 200.ms),
          const SizedBox(height: 60),
          Stack(
            children: [
              // Center Line
              if (!isMobile)
                Positioned(
                  left: MediaQuery.sizeOf(context).width / 2 - 80, // Adjust for horizontal padding 80
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 1,
                    color: AppColors.border,
                  ),
                ),
              
              // Mobile Line
              if (isMobile)
                Positioned(
                  left: 16,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 1,
                    color: AppColors.border,
                  ),
                ),

              Column(
                children: roles.indexed.map((e) {
                  final (i, role) = e;
                  final isLeft = i % 2 == 0;

                  if (isMobile) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 32, left: 40),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: -30,
                            top: 24,
                            child: _TimelineDot(),
                          ),
                          _JourneyCard(role: role, isLeft: false),
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      mainAxisAlignment: isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
                      children: [
                        if (isLeft) ...[
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: _JourneyCard(role: role, isLeft: true),
                              ),
                            ),
                          ),
                          _TimelineDot(),
                          const Expanded(child: SizedBox()),
                        ] else ...[
                          const Expanded(child: SizedBox()),
                          _TimelineDot(),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: _JourneyCard(role: role, isLeft: false),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimelineDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: AppColors.background,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.accent, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.5),
            blurRadius: 8,
          ),
        ],
      ),
    );
  }
}

class _JourneyCard extends StatefulWidget {
  const _JourneyCard({required this.role, required this.isLeft});
  final dynamic role;
  final bool isLeft;

  @override
  State<_JourneyCard> createState() => _JourneyCardState();
}

class _JourneyCardState extends State<_JourneyCard> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.role;
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: AnimatedContainer(
        duration: 300.ms,
        width: 480,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: _h ? AppColors.surfaceHover : AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _h ? AppColors.accent.withOpacity(0.4) : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: widget.isLeft ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              r.period,
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              r.title,
              textAlign: widget.isLeft ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.business_rounded, color: AppColors.textMuted, size: 14),
                const SizedBox(width: 8),
                Text(
                  '${r.company}  ·  ${r.location}',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              r.desc,
              textAlign: widget.isLeft ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ],
        ),
      ).animate().fadeIn().slideX(begin: widget.isLeft ? -0.1 : 0.1),
    );
  }
}
