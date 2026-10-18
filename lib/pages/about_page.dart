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
          style: TextStyle(
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
        child: Image.asset('assets/images/profile.jpeg', fit: BoxFit.cover),
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
        Text(
          "I am a Full Stack Developer with 4+ years of experience contributing to mobile applications, "
          "web platforms, SaaS products, and AI-powered automation workflows. Skilled in Laravel, PHP, JavaScript, "
          "Next.js, MySQL, and API integration, with deep expertise in Flutter and Dart.\n\n"
          "I have led and contributed to 40+ mobile and web projects across fintech, e-commerce, healthcare, and SaaS. "
          "My experience spans end-to-end product development, technical decision-making, application deployment "
          "on the App Store and Google Play, and advanced AI workflow automations using n8n and prompt engineering.",
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
      ('Location', 'Mirpur, Dhaka 🇧🇩'),
      ('Experience', '4+ Years'),
      ('Core Stack', 'Laravel, Next.js, Flutter, n8n'),
      ('Availability', 'Open to hire & contract'),
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
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.$2,
                style: TextStyle(
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
    _SkillItem('Flutter & Dart', 'Cross-Platform Mobile Ecosystem'),
    _SkillItem('Laravel & PHP', 'Backend APIs & Architecture'),
    _SkillItem('Next.js & JavaScript', 'Full-Stack Web & SSR'),
    _SkillItem('MySQL & Databases', 'Schema Design & Data Modeling'),
    _SkillItem('n8n Automation', 'AI Workflows & Pipeline Automation'),
    _SkillItem('Prompt Engineering', 'AI Agents & LLM Integration'),
    _SkillItem('Google Play & App Store', 'End-to-End Store Deployments'),
    _SkillItem('REST APIs & Auth', 'Secure Webhooks & Endpoints'),
    _SkillItem('Figma & UI/UX', 'Design Engineering & Prototypes'),
    _SkillItem('GitHub & CI/CD', 'Git Workflows & Automated Builds'),
    _SkillItem('State Management', 'BLoC, Provider & Reactive Patterns'),
    _SkillItem('Tailwind CSS', 'Modern Responsive Styling'),
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
              style: TextStyle(color: AppColors.textMuted, fontSize: 11),
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
      year: '04/2026 – Present',
      role: 'Full Stack Developer',
      company: 'Dhaka, Bangladesh',
      desc:
          'Lead technical execution across mobile applications, web platforms, SaaS products, and AI automation workflows. Contribute to product development, technical decision-making, and product strategy.',
    ),
    _TimelineItem(
      year: '05/2023 – 03/2026',
      role: 'Software Developer (Flutter)',
      company: 'AppDevs · Dhaka, Bangladesh',
      desc:
          'Managed end-to-end mobile app deployments on the App Store and Google Play at AppDevs. Resolved bugs, implemented client customizations, and collaborated across teams to deliver high-performance apps on schedule.',
    ),
    _TimelineItem(
      year: '10/2022 – 04/2023',
      role: 'Jr. Software Developer (Flutter)',
      company: 'Dhaka, Bangladesh',
      desc:
          'Delivered pixel-perfect UI across multiple Flutter projects. Worked on API integrations, connecting mobile applications with backend services.',
    ),
    _TimelineItem(
      year: '01/2022 – 01/2026',
      role: 'B.Sc in Computer Science & Engineering',
      company: 'Sonargaon University · Dhaka, Bangladesh',
      desc:
          'Degree program emphasizing algorithms, software engineering principles, relational databases, distributed systems, and computer architecture.',
    ),
    _TimelineItem(
      year: '07/2017 – 07/2021',
      role: 'Diploma in Computer Technology',
      company: 'Magura Polytechnic Institute · Magura, Bangladesh',
      desc:
          'Comprehensive 4-year technical diploma program with practical training in programming, computer networks, database systems, and electronics.',
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
                decoration: BoxDecoration(
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
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.role,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    item.company,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.desc,
                    style: TextStyle(
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
