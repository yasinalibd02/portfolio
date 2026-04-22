import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/web.dart' as web;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 700;
    return SingleChildScrollView(
      child: Column(
        children: [
          _HeroSection(isMobile: isMobile),
          const _PublishedAppsSection(),
          _TechStackMarquee(),
          _StatsBar(),
          _FooterStrip(),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// HERO
// ──────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.isMobile});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Mesh gradient blobs
        _GlowBlob(dx: 0.1, dy: 0.3, size: 380),
        _GlowBlob(dx: 0.85, dy: 0.6, size: 280),
        _GlowBlob(dx: 0.5, dy: 0.1, size: 200, color: const Color(0xFF0088FF)),

        // Content
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            isMobile ? 24 : 80,
            isMobile ? 110 : 150,
            isMobile ? 24 : 80,
            isMobile ? 60 : 100,
          ),
          child: Column(
            children: [
              // Badge
              _Badge().animate().fadeIn(duration: 600.ms).slideY(begin: -.3),

              SizedBox(height: isMobile ? 24 : 32),

              // Avatar
              _AvatarRing(size: isMobile ? 88 : 108)
                  .animate()
                  .fadeIn(delay: 100.ms, duration: 600.ms)
                  .scale(begin: const Offset(0.7, 0.7)),

              SizedBox(height: isMobile ? 24 : 32),

              // Greeting
              Text(
                "Hey, I'm",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 4),

              // Name
              ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColors.textPrimary, Color(0xFFB8D4FF)],
                    ).createShader(bounds),
                    child: Text(
                      'Yasin Ali',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 56 : 88,
                        fontWeight: FontWeight.w900,
                        height: 1.0,
                        letterSpacing: -2,
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 700.ms)
                  .slideY(begin: 0.2, end: 0)
                  .shimmer(delay: 1000.ms, duration: 2000.ms, color: Colors.white24),

              SizedBox(height: isMobile ? 12 : 16),

              // Role chip
              _RoleChip(isMobile: isMobile)
                  .animate()
                  .fadeIn(delay: 500.ms)
                  .scale(begin: const Offset(0.85, 0.85)),

              SizedBox(height: isMobile ? 20 : 28),

              // Description
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: const Text(
                  "Crafting beautiful, high-performance Flutter apps for mobile & web. "
                  "3+ years · 50+ apps shipped · 100+ store deployments.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 15.5,
                    height: 1.75,
                  ),
                ),
              ).animate().fadeIn(delay: 600.ms),

              SizedBox(height: isMobile ? 36 : 48),

              // CTAs
              Wrap(
                spacing: 14,
                runSpacing: 14,
                alignment: WrapAlignment.center,
                children: [
                  _GreenButton(
                    label: 'View Projects',
                    icon: Icons.arrow_forward_rounded,
                    onTap: (ctx) => ctx.go('/projects'),
                  ),
                  _OutlineButton(
                    label: 'Download Resume',
                    icon: Icons.download_rounded,
                    onTap: () {
                      final anchor = web.HTMLAnchorElement()
                        ..href = 'assets/MD_Yasin_Ali_Resume.pdf'
                        ..download = 'MD_Yasin_Ali_Resume.pdf';
                      anchor.click();
                    },
                  ),
                ],
              ).animate().fadeIn(delay: 800.ms),

              SizedBox(height: isMobile ? 40 : 56),

              // Social row
              _SocialRow().animate().fadeIn(delay: 1000.ms),
            ],
          ),
        ),
      ],
    );
  }
}

// Glow blob in background
class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.dx, required this.dy, required this.size, this.color});
  final double dx, dy, size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = 700.0;
    return Positioned(
      left: dx * w - size / 2,
      top: dy * h - size / 2,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [(color ?? AppColors.accent).withOpacity(0.15), Colors.transparent],
          ),
        ),
      )
      .animate(onPlay: (controller) => controller.repeat(reverse: true))
      .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.15, 1.15), duration: 4.seconds, curve: Curves.easeInOut)
      .slide(begin: const Offset(-0.02, -0.02), end: const Offset(0.02, 0.02), duration: 5.seconds, curve: Curves.easeInOut),
    );
  }
}

class _Badge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.08),
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PulsingDot(),
          const SizedBox(width: 8),
          const Text(
            'AVAILABLE FOR HIRE',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
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
        width: 7,
        height: 7,
        decoration: const BoxDecoration(
          color: AppColors.accent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _AvatarRing extends StatelessWidget {
  const _AvatarRing({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const SweepGradient(
          colors: [AppColors.accent, Color(0xFF005F35), AppColors.accent],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentGlow,
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.background,
        ),
        padding: const EdgeInsets.all(3),
        child: CircleAvatar(
          radius: size / 2,
          backgroundImage: const AssetImage('assets/images/profile.png'),
        ),
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  const _RoleChip({required this.isMobile});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 22,
        vertical: isMobile ? 8 : 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Flutter Developer & Mobile App Specialist',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Buttons ───────────────────────────────────────────
class _GreenButton extends StatefulWidget {
  const _GreenButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final void Function(BuildContext) onTap;

  @override
  State<_GreenButton> createState() => _GreenButtonState();
}

class _GreenButtonState extends State<_GreenButton> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onTap(context),
        child: AnimatedContainer(
          duration: 200.ms,
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
          decoration: BoxDecoration(
            color: _h ? AppColors.accentDark : AppColors.accent,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentGlow,
                blurRadius: _h ? 32 : 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  color: AppColors.background,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5,
                ),
              ),
              const SizedBox(width: 8),
              Icon(widget.icon, color: AppColors.background, size: 17),
            ],
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
          decoration: BoxDecoration(
            color: _h ? AppColors.surfaceHover : Colors.transparent,
            border: Border.all(
              color: _h
                  ? AppColors.textSecondary.withOpacity(0.4)
                  : AppColors.border,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: _h ? AppColors.textPrimary : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                widget.icon,
                color: _h ? AppColors.textPrimary : AppColors.textSecondary,
                size: 17,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Social Row ─────────────────────────────────────────
class _SocialRow extends StatelessWidget {
  final _socials = const [
    (FontAwesomeIcons.github, 'https://github.com/yasinalibd02'),
    (FontAwesomeIcons.linkedin, 'https://www.linkedin.com/in/yasinalibd02'),
    (FontAwesomeIcons.twitter, 'https://x.com/YasinAl99967413'),
    (FontAwesomeIcons.whatsapp, 'https://wa.me/8801308985262'),
    (FontAwesomeIcons.facebook, 'https://www.facebook.com/yasinarafat02'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _socials
              .map((s) => _SocialIcon(icon: s.$1, url: s.$2))
              .toList(),
        ),
        const SizedBox(height: 12),
        const Text(
          'Find me on',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  const _SocialIcon({required this.icon, required this.url});
  final IconData icon;
  final String url;

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        child: AnimatedContainer(
          duration: 200.ms,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: _h
                ? AppColors.accent.withOpacity(0.12)
                : AppColors.surfaceCard,
            border: Border.all(
              color: _h ? AppColors.accent.withOpacity(0.45) : AppColors.border,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: FaIcon(
            widget.icon,
            size: 16,
            color: _h ? AppColors.accent : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// PUBLISHED APPS
// ──────────────────────────────────────────────────────────
class _PublishedAppsSection extends StatelessWidget {
  const _PublishedAppsSection();

  static const _apps = [
    (
      name: 'AppDevs - FinTech Software',
      category: 'Finance',
      icon: FontAwesomeIcons.googlePlay,
      store: 'Play Store',
      url: 'https://play.google.com/store/apps/details?id=net.appdevs',
    ),
    (
      name: 'QRPay - Money Transfer',
      category: 'Finance',
      icon: FontAwesomeIcons.googlePlay,
      store: 'Play Store',
      url: 'https://play.google.com/store/apps/details?id=net.appdevs.qrpayuser',
    ),
    (
      name: 'MMeldaPay',
      category: 'Finance',
      icon: FontAwesomeIcons.apple,
      store: 'App Store',
      url: 'https://apps.apple.com/gb/app/mmeldpay-agent/id6755371498',
    ),
    (
      name: 'SenPay',
      category: 'Finance',
      icon: FontAwesomeIcons.apple,
      store: 'App Store',
      url: 'https://apps.apple.com/us/app/senpay-user/id6746039031',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 700;

    return Container(
      width: double.infinity,
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
              const Text(
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
          const SizedBox(height: 24),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: _apps.indexed.map((e) {
              final (i, app) = e;
              return _PublishedAppCard(
                name: app.name,
                category: app.category,
                icon: app.icon,
                store: app.store,
                url: app.url,
              ).animate().fadeIn(delay: (i * 100).ms).slideY(begin: 0.1, end: 0);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _PublishedAppCard extends StatefulWidget {
  const _PublishedAppCard({
    required this.name,
    required this.category,
    required this.icon,
    required this.store,
    required this.url,
  });

  final String name, category, store, url;
  final IconData icon;

  @override
  State<_PublishedAppCard> createState() => _PublishedAppCardState();
}

class _PublishedAppCardState extends State<_PublishedAppCard> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 700;
    final w = isMobile ? double.infinity : 340.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        child: AnimatedContainer(
          duration: 250.ms,
          width: w,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _h ? AppColors.surfaceHover : AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _h ? AppColors.accent.withOpacity(0.4) : AppColors.border,
            ),
            boxShadow: _h
                ? [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: FaIcon(
                      widget.icon,
                      color: widget.store == 'Play Store' 
                          ? AppColors.accent 
                          : AppColors.textPrimary,
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      widget.category,
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.name,
                style: TextStyle(
                  color: _h ? AppColors.accent : AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    'Available on ${widget.store}',
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: _h ? AppColors.accent : AppColors.textMuted,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// TECH marquee
// ──────────────────────────────────────────────────────────
class _TechStackMarquee extends StatelessWidget {
  static const _techs = [
    'Flutter',
    'Dart',
    'Firebase',
    'REST API',
    'BLoC',
    'Provider',
    'Git',
    'Figma',
    'Android',
    'iOS',
    'CI/CD',
    'Clean Arch',
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
          const Text(
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
              ? AppColors.accent.withOpacity(0.10)
              : AppColors.surfaceCard,
          border: Border.all(
            color: _h ? AppColors.accent.withOpacity(0.4) : AppColors.border,
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
      ('3+', 'Years', 'Experience'),
      ('50+', 'Apps', 'Built'),
      ('100+', 'Store', 'Deployments'),
      ('2', 'Happy', 'Clients'),
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
            color: AppColors.accent.withOpacity(0.04),
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
          style: const TextStyle(
            color: AppColors.accent,
            fontSize: 42,
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
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              TextSpan(
                text: label2,
                style: const TextStyle(
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
          const Divider(color: AppColors.border),
          const SizedBox(height: 20),
          const Text(
            '© 2025 Yasin Ali · Flutter Developer',
            style: TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
