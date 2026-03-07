import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<dynamic> _projects = [];
  bool _isLoading = true;
  String _selectedTag = 'All';

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/projects.json',
      );
      final List<dynamic> data = json.decode(response);
      setState(() {
        _projects = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  List<String> get _allTags {
    final tags = <String>{'All'};
    for (final p in _projects) {
      for (final t in (p['tags'] as List<dynamic>? ?? [])) {
        tags.add(t.toString());
      }
    }
    return tags.toList();
  }

  List<dynamic> get _filtered {
    if (_selectedTag == 'All') return _projects;
    return _projects
        .where(
          (p) => (p['tags'] as List<dynamic>? ?? []).contains(_selectedTag),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 700;

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
          // Label
          _SectionLabel(label: 'MY WORK').animate().fadeIn(),
          const SizedBox(height: 16),

          // Heading
          Text(
            'Featured Projects',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: isMobile ? 36 : 56,
              fontWeight: FontWeight.w900,
            ),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 8),
          const Text(
            '50+ apps shipped across fintech, healthcare, e-commerce & more.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 32),

          // Filter chips
          if (!_isLoading)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _allTags.map((tag) {
                  final isActive = _selectedTag == tag;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTag = tag),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.accent
                            : AppColors.surfaceCard,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: isActive ? AppColors.accent : AppColors.border,
                        ),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: isActive
                              ? AppColors.background
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ).animate().fadeIn(delay: 300.ms),

          const SizedBox(height: 40),

          // Grid
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            )
          else if (_filtered.isEmpty)
            const Center(
              child: Text(
                'No projects found.',
                style: TextStyle(color: AppColors.textMuted),
              ),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.maxWidth;
                int cols = 1;
                if (w > 900)
                  cols = 3;
                else if (w > 550)
                  cols = 2;

                // Build rows of `cols` cards, each row is an IntrinsicHeight row
                final List<Widget> rows = [];
                for (int i = 0; i < _filtered.length; i += cols) {
                  final rowItems = _filtered.sublist(
                    i,
                    (i + cols).clamp(0, _filtered.length),
                  );
                  rows.add(
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (int j = 0; j < rowItems.length; j++) ...[
                            Expanded(
                              child:
                                  _ProjectCard(
                                        title: rowItems[j]['title'] ?? '',
                                        description:
                                            rowItems[j]['description'] ?? '',
                                        imageUrl: rowItems[j]['imageUrl'] ?? '',
                                        link: rowItems[j]['link'] ?? '',
                                        tags:
                                            (rowItems[j]['tags']
                                                    as List<dynamic>?)
                                                ?.map((e) => e.toString())
                                                .toList() ??
                                            [],
                                      )
                                      .animate()
                                      .fadeIn(delay: ((i + j) * 80).ms)
                                      .scale(begin: const Offset(0.92, 0.92)),
                            ),
                            if (j < rowItems.length - 1)
                              const SizedBox(width: 20),
                          ],
                          // Fill remaining slots if last row is not full
                          for (int k = rowItems.length; k < cols; k++) ...[
                            const SizedBox(width: 20),
                            const Expanded(child: SizedBox()),
                          ],
                        ],
                      ),
                    ),
                  );
                  if (i + cols < _filtered.length) {
                    rows.add(const SizedBox(height: 20));
                  }
                }
                return Column(children: rows);
              },
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────
// Project Card
// ─────────────────────────────────
class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.link,
    required this.tags,
  });
  final String title;
  final String description;
  final String imageUrl;
  final String link;
  final List<String> tags;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.identity()..translate(0.0, _hovered ? -6.0 : 0.0),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withOpacity(0.35)
                : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, 16),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image area with contained display ──
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Container(
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFF0D1A2D), AppColors.surfaceCard],
                  ),
                ),
                child: Stack(
                  children: [
                    // Dot grid pattern for empty parts
                    Positioned.fill(
                      child: CustomPaint(painter: _DotGridPainter()),
                    ),
                    // The actual image - contained and centered
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Image.asset(
                          widget.imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.apps_rounded,
                                color: AppColors.textMuted,
                                size: 48,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Preview unavailable',
                                style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Top right — small category badge overlaid on image
                    if (widget.tags.isNotEmpty)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text(
                            widget.tags.first,
                            style: const TextStyle(
                              color: AppColors.accent,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    // Hover overlay gradient
                    if (_hovered)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppColors.accent.withOpacity(0.06),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tags row
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: widget.tags.take(3).map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: AppColors.accent,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Description — 3 lines max, no Expanded
                  Text(
                    widget.description,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                      height: 1.6,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  // CTA
                  GestureDetector(
                    onTap: () async {
                      if (widget.link.isNotEmpty) {
                        final uri = Uri.parse(widget.link);
                        if (await canLaunchUrl(uri)) await launchUrl(uri);
                      }
                    },
                    child: Row(
                      children: [
                        const Text(
                          'View Project',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const FaIcon(
                          FontAwesomeIcons.arrowUpRightFromSquare,
                          size: 12,
                          color: AppColors.accent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Shared label widget
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
// Dot grid background painter
// ─────────────────────────────────
class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 20.0;
    const radius = 1.2;
    final paint = Paint()
      ..color = const Color(0x12FFFFFF)
      ..style = PaintingStyle.fill;

    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotGridPainter oldDelegate) => false;
}
