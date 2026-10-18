import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String _selectedFilter = 'All';
  String _searchQuery = '';
  final TextEditingController _searchCtrl = TextEditingController();

  final List<String> _primaryFilters = [
    'All',
    'Live Web',
    'Mobile App',
    'E-Commerce',
    'FinTech',
    'Real Estate',
    'Agency & SaaS',
    'Logistics',
    'Travel & Booking',
  ];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
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

  int _countFor(String filter) {
    if (filter == 'All') return _projects.length;
    return _projects.where((p) {
      final tags = (p['tags'] as List<dynamic>? ?? [])
          .map((e) => e.toString().toLowerCase())
          .toList();
      final cat = (p['category'] ?? '').toString().toLowerCase();
      final type = (p['type'] ?? '').toString().toLowerCase();
      final f = filter.toLowerCase();

      if (f == 'live web') return type == 'web' || tags.contains('live web');
      if (f == 'mobile app') return type == 'app' || tags.contains('mobile app');
      if (f == 'fintech') return cat.contains('fintech') || tags.contains('fintech');
      if (f == 'agency & saas') return cat.contains('agency') || cat.contains('saas');
      return cat.contains(f) || tags.contains(f);
    }).length;
  }

  List<dynamic> get _filtered {
    var list = _projects;

    // Filter by category / tag
    if (_selectedFilter != 'All') {
      final f = _selectedFilter.toLowerCase();
      list = list.where((p) {
        final tags = (p['tags'] as List<dynamic>? ?? [])
            .map((e) => e.toString().toLowerCase())
            .toList();
        final cat = (p['category'] ?? '').toString().toLowerCase();
        final type = (p['type'] ?? '').toString().toLowerCase();

        if (f == 'live web') return type == 'web' || tags.contains('live web');
        if (f == 'mobile app') return type == 'app' || tags.contains('mobile app');
        if (f == 'fintech') return cat.contains('fintech') || tags.contains('fintech');
        if (f == 'agency & saas') return cat.contains('agency') || cat.contains('saas');
        return cat.contains(f) || tags.contains(f);
      }).toList();
    }

    // Filter by search query
    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.trim().toLowerCase();
      list = list.where((p) {
        final title = (p['title'] ?? '').toString().toLowerCase();
        final desc = (p['description'] ?? '').toString().toLowerCase();
        final cat = (p['category'] ?? '').toString().toLowerCase();
        final tags = (p['tags'] as List<dynamic>? ?? [])
            .map((e) => e.toString().toLowerCase())
            .join(' ');
        return title.contains(q) ||
            desc.contains(q) ||
            cat.contains(q) ||
            tags.contains(q);
      }).toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 700;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 16 : (width > 1200 ? 70 : 36),
        isMobile ? 24 : 80,
        isMobile ? 16 : (width > 1200 ? 70 : 36),
        60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Label ──
          _SectionLabel(label: 'ENGINEERING & DESIGN PORTFOLIO')
              .animate()
              .fadeIn(),

          const SizedBox(height: 16),

          // ── Heading & Stats Ribbon ──
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: 24,
            runSpacing: 20,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Featured Projects & ',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: isMobile ? 32 : 52,
                              fontWeight: FontWeight.w900,
                              height: 1.15,
                              letterSpacing: -1.5,
                            ),
                          ),
                          TextSpan(
                            text: 'Live Systems',
                            style: TextStyle(
                              color: AppColors.accent,
                              fontSize: isMobile ? 32 : 52,
                              fontWeight: FontWeight.w900,
                              height: 1.15,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'A curated collection of live web platforms, production enterprise systems, and mobile applications built for real clients, high transaction volumes, and global markets.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15.5,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              // Summary Stats Chips
              _ProjectsOverviewRibbon(
                total: _projects.length,
                webCount: _countFor('Live Web'),
                appsCount: _countFor('Mobile App'),
              ),
            ],
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),

          const SizedBox(height: 36),

          // ── Search & Filter Bar ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Input Field
                TextField(
                  controller: _searchCtrl,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.5,
                  ),
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText:
                        'Search by project name, tech stack (e.g. Flutter, Laravel, Tailwind, E-Commerce)...',
                    hintStyle: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppColors.accent,
                      size: 22,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.close_rounded,
                              color: AppColors.textSecondary,
                              size: 18,
                            ),
                            onPressed: () {
                              _searchCtrl.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.accent,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Category Filter Pills
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _primaryFilters.map((filter) {
                      final isActive = _selectedFilter == filter;
                      final count = _countFor(filter);
                      if (count == 0 && filter != 'All') {
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedFilter = filter),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.accent
                                    : AppColors.surface,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: isActive
                                      ? AppColors.accent
                                      : AppColors.border,
                                  width: 1.2,
                                ),
                                boxShadow: isActive
                                    ? [
                                        BoxShadow(
                                          color: AppColors.accentGlow,
                                          blurRadius: 16,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    filter,
                                    style: TextStyle(
                                      color: isActive
                                          ? AppColors.onAccent
                                          : AppColors.textPrimary,
                                      fontWeight: isActive
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 1.5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? Colors.black.withValues(alpha: 0.15)
                                          : AppColors.surfaceCard,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '$count',
                                      style: TextStyle(
                                        color: isActive
                                            ? AppColors.onAccent
                                            : AppColors.textMuted,
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 36),

          // ── Projects Grid ──
          if (_isLoading)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(60),
                child: CircularProgressIndicator(color: AppColors.accent),
              ),
            )
          else if (_filtered.isEmpty)
            Center(
              child: Container(
                padding: const EdgeInsets.all(48),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off_rounded,
                      size: 64,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No matching projects found',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try adjusting your search query or switching filter tabs.',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.maxWidth;
                final isMobile = w < 700;
                final cols = w > 950 ? 3 : 2;
                final gap = isMobile ? 12.0 : 24.0;
                final items = _filtered;

                final List<Widget> rows = [];
                for (int i = 0; i < items.length; i += cols) {
                  final chunk = items.sublist(
                    i,
                    (i + cols).clamp(0, items.length),
                  );

                  rows.add(
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (int j = 0; j < chunk.length; j++) ...[
                            Expanded(
                              child: _ModernProjectCard(
                                project: chunk[j] as Map<String, dynamic>,
                                isMobile: isMobile,
                              )
                                  .animate()
                                  .fadeIn(delay: ((i + j) * 60).ms)
                                  .slideY(begin: 0.08, end: 0),
                            ),
                            if (j < chunk.length - 1)
                              SizedBox(width: gap),
                          ],
                          for (int k = chunk.length; k < cols; k++) ...[
                            SizedBox(width: gap),
                            const Expanded(child: SizedBox()),
                          ],
                        ],
                      ),
                    ),
                  );

                  if (i + cols < items.length) {
                    rows.add(SizedBox(height: gap));
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

// ──────────────────────────────────────────────────────────
// Overview Ribbon
// ──────────────────────────────────────────────────────────
class _ProjectsOverviewRibbon extends StatelessWidget {
  const _ProjectsOverviewRibbon({
    required this.total,
    required this.webCount,
    required this.appsCount,
  });
  final int total, webCount, appsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MiniStat(num: '$total+', label: 'Total Projects'),
          Container(
            width: 1,
            height: 28,
            color: AppColors.border,
            margin: const EdgeInsets.symmetric(horizontal: 14),
          ),
          _MiniStat(num: '$webCount', label: 'Live Web'),
          Container(
            width: 1,
            height: 28,
            color: AppColors.border,
            margin: const EdgeInsets.symmetric(horizontal: 14),
          ),
          _MiniStat(num: '$appsCount', label: 'Mobile Apps'),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.num, required this.label});
  final String num, label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          num,
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────
// Modern Dynamic Project Card
// ──────────────────────────────────────────────────────────
class _ModernProjectCard extends StatefulWidget {
  const _ModernProjectCard({required this.project, this.isMobile = false});
  final Map<String, dynamic> project;
  final bool isMobile;

  @override
  State<_ModernProjectCard> createState() => _ModernProjectCardState();
}

class _ModernProjectCardState extends State<_ModernProjectCard> {
  bool _hovered = false;

  bool get _isWeb => widget.project['type'] == 'web';

  Color get _tint {
    final cat = (widget.project['category'] ?? '').toString().toLowerCase();
    if (cat.contains('real estate')) return const Color(0xFFD4AF37);
    if (cat.contains('agency') || cat.contains('saas')) {
      return const Color(0xFFF4795B);
    }
    if (cat.contains('e-commerce') &&
        (widget.project['title'] ?? '').toString().contains('Gadget')) {
      return const Color(0xFF00D2FF);
    }
    if (cat.contains('e-commerce') &&
        (widget.project['title'] ?? '').toString().contains('Kiam')) {
      return const Color(0xFFE53935);
    }
    if (cat.contains('travel') || cat.contains('booking')) {
      return const Color(0xFF0284C7);
    }
    if ((widget.project['title'] ?? '').toString().contains('Vape')) {
      return const Color(0xFF13C044);
    }
    if (cat.contains('fashion')) return const Color(0xFFD4AF37);
    if (cat.contains('logistics')) return const Color(0xFFF97316);
    if (cat.contains('crypto')) return const Color(0xFF8B5CF6);
    return AppColors.accent;
  }

  Future<void> _openLink() async {
    final link = (widget.project['link'] ?? '').toString();
    if (link.isNotEmpty) {
      final uri = Uri.parse(link);
      if (await canLaunchUrl(uri)) await launchUrl(uri);
    }
  }

  void _copyLink() {
    final link = (widget.project['link'] ?? '').toString();
    if (link.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: link));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 10),
              Text('Copied link: $link'),
            ],
          ),
          backgroundColor: AppColors.surfaceCard,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.accent.withValues(alpha: 0.5)),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final isMobile = widget.isMobile;
    final title = p['title'] ?? '';
    final description = p['description'] ?? '';
    final imageUrl = p['imageUrl'] ?? '';
    final tags = (p['tags'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    final badge = p['badge'] ?? (_isWeb ? 'Live Production' : 'Featured App');
    final domain = (_isWeb && p['link'] != null)
        ? Uri.parse(p['link']).host
        : (_isWeb ? 'Live Platform' : 'App Showcase');

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _hovered ? -8.0 : 0.0, 0.0),

        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
          border: Border.all(
            color: _hovered
                ? _tint.withValues(alpha: 0.55)
                : AppColors.border,
            width: _hovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? _tint.withValues(alpha: 0.18)
                  : Colors.black.withValues(alpha: 0.10),
              blurRadius: _hovered ? 36 : 14,
              offset: Offset(0, _hovered ? 18 : 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top Header Chrome (macOS Browser for Web, Device Chrome for Apps) ──
            Container(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 14, vertical: isMobile ? 7 : 10),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(19),
                ),
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  if (_isWeb) ...[
                    // 3 macOS dots
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFF5F56),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFFBD2E),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF27C93F),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    // Mock URL Address bar
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3.5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.border.withValues(alpha: 0.6),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_rounded,
                              size: 10,
                              color: AppColors.accent,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                domain,
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    Icon(
                      Icons.smartphone_rounded,
                      size: 14,
                      color: AppColors.secondaryAccent,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Mobile App Ecosystem',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(width: 8),

                  // Live or Status Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: _tint.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _tint.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _tint,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          _isWeb ? 'LIVE' : 'SHIPPED',
                          style: TextStyle(
                            color: _tint,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Image Showcase Area ──
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _openLink,
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image with smooth zoom
                      AnimatedScale(
                        scale: _hovered ? 1.05 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        child: Image.asset(
                          imageUrl,
                          fit: _isWeb ? BoxFit.cover : BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: AppColors.surface,
                            child: Center(
                              child: Icon(
                                Icons.apps_rounded,
                                size: 48,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Gradient vignette
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.25),
                              Colors.black.withValues(alpha: 0.75),
                            ],
                            stops: const [0.4, 0.75, 1.0],
                          ),
                        ),
                      ),

                      // Top right: Badge
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 3.5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _tint.withValues(alpha: 0.45),
                            ),
                          ),
                          child: Text(
                            badge,
                            style: TextStyle(
                              color: _tint,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      // Bottom left: Category
                      if (p['category'] != null)
                        Positioned(
                          bottom: 10,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 3.5,
                            ),
                            decoration: BoxDecoration(
                              color: _tint.withValues(alpha: 0.22),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: _tint.withValues(alpha: 0.45),
                              ),
                            ),
                            child: Text(
                              p['category'].toString(),
                              style: TextStyle(
                                color: _tint,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                      // Launch Hover Overlay
                      if (_hovered)
                        Container(
                          color: Colors.black.withValues(alpha: 0.25),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: _tint,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: _tint.withValues(alpha: 0.5),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _isWeb ? 'Visit Site' : 'View Project',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const FaIcon(
                                    FontAwesomeIcons.arrowUpRightFromSquare,
                                    size: 11,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Content Area ──
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 11 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.textPrimary,
                        fontSize: isMobile ? 14.5 : 17.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: isMobile ? 4 : 8),

                    // Description
                    ConstrainedBox(
                      constraints: BoxConstraints(minHeight: isMobile ? 30 : 38),
                      child: Text(
                        description,
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                          fontSize: isMobile ? 11 : 13,
                          height: 1.45,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: isMobile ? 8 : 14),

                    // Tags
                    Wrap(
                      spacing: isMobile ? 4 : 6,
                      runSpacing: isMobile ? 4 : 6,
                      children: tags.take(isMobile ? 2 : 4).map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 6 : 9,
                            vertical: isMobile ? 2.5 : 3.5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: AppColors.border.withValues(alpha: 0.8),
                            ),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: isMobile ? 9.5 : 10.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const Spacer(),
                    SizedBox(height: isMobile ? 10 : 16),

                    // ── Actions Footer ──
                    Container(
                      padding: EdgeInsets.only(top: isMobile ? 10 : 14),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.border.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _openLink,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: EdgeInsets.symmetric(
                                    vertical: isMobile ? 7.5 : 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _hovered
                                        ? _tint
                                        : _tint.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
                                    border: Border.all(
                                      color: _hovered
                                          ? _tint
                                          : _tint.withValues(alpha: 0.35),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _isWeb ? 'Visit Live Site' : 'View Project',
                                        style: TextStyle(
                                          color: _hovered
                                              ? Colors.black
                                              : _tint,
                                          fontSize: isMobile ? 11.5 : 12.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      FaIcon(
                                        FontAwesomeIcons.arrowUpRightFromSquare,
                                        size: isMobile ? 9.5 : 11,
                                        color: _hovered
                                            ? Colors.black
                                            : _tint,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: isMobile ? 6 : 10),

                          // Copy Link
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Tooltip(
                              message: 'Copy URL',
                              child: GestureDetector(
                                onTap: _copyLink,
                                child: Container(
                                  width: isMobile ? 32 : 38,
                                  height: isMobile ? 32 : 38,
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.copy_rounded,
                                      size: isMobile ? 14 : 16,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// Section Label
// ──────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.accent, AppColors.secondaryAccent],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          margin: const EdgeInsets.only(right: 10),
        ),
        Text(
          label,
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
