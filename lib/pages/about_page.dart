import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 800;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 24 : 80,
        isMobile ? 32 : 100,
        isMobile ? 24 : 80,
        60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section label
          _SectionLabel(label: 'WHO I AM').animate().fadeIn(),

          const SizedBox(height: 16),

          // ── Heading
          Text(
            'About Me',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: isMobile ? 36 : 56,
              fontWeight: FontWeight.w900,
            ),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 48),

          // ── Bio + Photo
          isMobile ? _MobileBio() : _DesktopBio(),

          const SizedBox(height: 64),

          // ── Skills
          _SectionLabel(label: 'MY SKILLS').animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 16),
          Text(
            'Technologies & Tools',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.w800,
            ),
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 32),
          _SkillsGrid().animate().fadeIn(delay: 400.ms),

          const SizedBox(height: 64),

          // ── Experience Timeline
          _SectionLabel(label: 'MY JOURNEY').animate().fadeIn(delay: 500.ms),
          const SizedBox(height: 16),
          Text(
            'Career Timeline',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.w800,
            ),
          ).animate().fadeIn(delay: 600.ms),
          const SizedBox(height: 32),
          _Timeline().animate().fadeIn(delay: 700.ms),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 2,
          color: AppColors.accent,
          margin: const EdgeInsets.only(right: 10),
        ),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.accent,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────
// Bio Sections
// ─────────────────────────────────
class _DesktopBio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Photo
        Expanded(flex: 2, child: _ProfilePhoto()),
        const SizedBox(width: 64),
        // Text + Stats
        Expanded(flex: 3, child: _BioContent()),
      ],
    );
  }
}

class _MobileBio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_ProfilePhoto(), const SizedBox(height: 32), _BioContent()],
    );
  }
}

class _ProfilePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentGlow,
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset('assets/images/profile.png', fit: BoxFit.cover),
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.95, 0.95));
  }
}

class _BioContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "I am a Software Engineer specializing in cross-platform mobile app development "
          "using Flutter. With 3+ years of professional experience, I have developed 50+ "
          "high-quality applications across diverse industries such as fintech, e-commerce, "
          "healthcare, crypto, transportation, and car rental.\n\n"
          "I have also handled direct communication with clients, understanding their "
          "requirements, providing technical guidance, and delivering solutions that match "
          "their business goals.",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15,
            height: 1.9,
          ),
        ),
        const SizedBox(height: 32),
        _InfoGrid(),
      ],
    );
  }
}

class _InfoGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      ('Location', 'Bangladesh 🇧🇩'),
      ('Experience', '3+ Years'),
      ('Speciality', 'Flutter & Dart'),
      ('Availability', 'Open to hire'),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 3.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.$1,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.$2,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────
// Skills
// ─────────────────────────────────
class _SkillsGrid extends StatelessWidget {
  final _skills = [
    _SkillItem('Flutter', 'Mobile / Web / Desktop'),
    _SkillItem('Dart', 'Programming Language'),
    _SkillItem('Firebase', 'Auth, Firestore, Cloud'),
    _SkillItem('REST API', 'Integration & Design'),
    _SkillItem('Git & GitHub', 'Version Control'),
    _SkillItem('Figma', 'UI/UX Prototyping'),
    _SkillItem('Android', 'Native Kotlin/Java'),
    _SkillItem('iOS', 'Swift & App Store'),
    _SkillItem('State Mgmt', 'BLoC, Provider, Riverpod'),
    _SkillItem('CI/CD', 'GitHub Actions, Fastlane'),
    _SkillItem('Clean Arch', 'SOLID & Design Patterns'),
    _SkillItem('Testing', 'Unit & Widget Tests'),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 700;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: isMobile ? 2.2 : 2.8,
      ),
      itemCount: _skills.length,
      itemBuilder: (context, i) {
        return _SkillCard(skill: _skills[i])
            .animate()
            .fadeIn(delay: (i * 60).ms)
            .scale(begin: const Offset(0.85, 0.85));
      },
    );
  }
}

class _SkillItem {
  final String name;
  final String sub;
  const _SkillItem(this.name, this.sub);
}

class _SkillCard extends StatefulWidget {
  const _SkillCard({required this.skill});
  final _SkillItem skill;

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.accent.withOpacity(0.08)
              : AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withOpacity(0.4)
                : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.skill.name,
              style: TextStyle(
                color: _hovered ? AppColors.accent : AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.skill.sub,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// Timeline
// ─────────────────────────────────
class _Timeline extends StatelessWidget {
  final _items = const [
    _TimelineItem(
      year: '2024 – Present',
      role: 'Senior Flutter Developer',
      company: 'Freelance / Remote',
      desc:
          'Building premium apps for global clients including fintech, healthcare, and e-commerce platforms. Deployed 20+ apps to Play Store & App Store.',
    ),
    _TimelineItem(
      year: '2022 – 2024',
      role: 'Flutter Developer',
      company: 'Software Agency',
      desc:
          'Developed 30+ cross-platform apps. Led UI/UX implementation, state management (BLoC/Provider), and Firebase integration.',
    ),
    _TimelineItem(
      year: '2021 – 2022',
      role: 'Junior Flutter Developer',
      company: 'Startup',
      desc:
          'Began Flutter journey building e-commerce and social apps. Hands-on with REST APIs, animations, and app deployment.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _items.indexed.map((entry) {
        final (i, item) = entry;
        return _TimelineCard(
          item: item,
          isLast: i == _items.length - 1,
        ).animate().fadeIn(delay: (i * 150).ms).slideX(begin: -0.1, end: 0);
      }).toList(),
    );
  }
}

class _TimelineItem {
  final String year;
  final String role;
  final String company;
  final String desc;
  const _TimelineItem({
    required this.year,
    required this.role,
    required this.company,
    required this.desc,
  });
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({required this.item, required this.isLast});
  final _TimelineItem item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot + line
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1,
                    color: AppColors.border,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.year,
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.role,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    item.company,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.desc,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 14,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
