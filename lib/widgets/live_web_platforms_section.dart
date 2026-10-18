import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class WebPlatformData {
  final String title;
  final String categoryLine;
  final String category;
  final String filterGroup;
  final String description;
  final String url;
  final String screenshot;
  final String badge;
  final List<String> tags;

  const WebPlatformData({
    required this.title,
    required this.categoryLine,
    required this.category,
    required this.filterGroup,
    required this.description,
    required this.url,
    required this.screenshot,
    required this.badge,
    required this.tags,
  });
}

const List<WebPlatformData> kLiveWebPlatforms = [
  WebPlatformData(
    title: 'ShopGrow',
    categoryLine: 'Agency & SaaS • Multi-Channel AI Agent',
    category: 'Agency & SaaS',
    filterGroup: 'Agency & SaaS',
    description:
        'SaaS platform to build one AI agent and deploy to WhatsApp, Instagram, Facebook, TikTok, and website.',
    url: 'https://shopgrow.net/',
    screenshot: 'assets/images/web/shopgrow.webp',
    badge: 'Featured SaaS',
    tags: ['AI Agents', 'Multi-Channel', 'bKash/Nagad'],
  ),
  WebPlatformData(
    title: 'Luxora Living',
    categoryLine: 'Real Estate • Corporate Website',
    category: 'Real Estate',
    filterGroup: 'Real Estate',
    description:
        'Showcase website for a premium residential real estate developer in Bangladesh with virtual unit browsing.',
    url: 'https://luxoralivingbd.com',
    screenshot: 'assets/images/web/luxora.webp',
    badge: 'Live Client',
    tags: ['Project Showcase', 'Property Details', 'Enquiries'],
  ),
  WebPlatformData(
    title: 'Happy Vacation',
    categoryLine: 'Travel & Booking • Flight & Packages',
    category: 'Travel & Booking',
    filterGroup: 'Travel & Booking',
    description:
        'Travel agency platform featuring real-time flight inquiry forms, Hajj & Umrah booking, and tour packages.',
    url: 'https://happyvacationbd.com/',
    screenshot: 'assets/images/web/happy_vacation.webp',
    badge: 'Live Client',
    tags: ['Flight Search', 'Hajj & Umrah', 'Visa Consulting'],
  ),
  WebPlatformData(
    title: 'AN Express BD',
    categoryLine: 'Logistics • Courier & Logistics',
    category: 'Logistics',
    filterGroup: 'Logistics',
    description:
        'Nationwide courier logistics platform featuring live consignment tracking by ID and parcel fee calculator.',
    url: 'https://anexpressbd.com/',
    screenshot: 'assets/images/web/anexpress.webp',
    badge: 'Live Client',
    tags: ['Live Tracking', 'Fee Calculator', '400+ Hubs'],
  ),
  WebPlatformData(
    title: 'Kiam Express',
    categoryLine: 'E-commerce • Kitchen & Home Essentials',
    category: 'E-Commerce',
    filterGroup: 'E-Commerce',
    description:
        'Official e-commerce destination for Kiam cookware, kitchen appliances, and home essentials with nationwide fast delivery.',
    url: 'https://kiamexpress.com/',
    screenshot: 'assets/images/web/kiam.webp',
    badge: 'Live Client',
    tags: ['Kitchen & Home', 'Online Store', 'Fast Shipping'],
  ),
  WebPlatformData(
    title: 'Vape Empire',
    categoryLine: 'E-commerce • Age-Restricted Retail',
    category: 'E-Commerce',
    filterGroup: 'E-Commerce',
    description:
        'Modern dark-themed vape marketplace featuring age verification gate, multi-brand filtering, and instant checkout.',
    url: 'https://vapeempire.net/',
    screenshot: 'assets/images/web/vape_empire.webp',
    badge: 'Live Client',
    tags: ['Age Gate', 'Brand Filters', 'Instant Order'],
  ),
  WebPlatformData(
    title: 'AppDevs',
    categoryLine: 'Agency & SaaS • FinTech Software Company',
    category: 'Agency & SaaS',
    filterGroup: 'Agency & SaaS',
    description:
        'Official website and enterprise showcase for AppDevs, highlighting high-performance financial software engineering and mobile apps.',
    url: 'https://appdevs.net/',
    screenshot: 'assets/images/apps/appdevs_shot.jpg',
    badge: 'Enterprise Platform',
    tags: ['FinTech', 'SaaS Architecture', 'Payment Gateways'],
  ),
  WebPlatformData(
    title: 'QRPay Pro',
    categoryLine: 'FinTech • Digital Payment Ecosystem',
    category: 'Agency & SaaS',
    filterGroup: 'Agency & SaaS',
    description:
        'Complete digital payment ecosystem with user wallet, QR code payments, merchant portal, and agent banking.',
    url:
        'https://codecanyon.net/item/qrpay-pro-complete-qrpay-solution-with-all-addons-bundle/56101909',
    screenshot: 'assets/images/apps/qrpay_shot.jpg',
    badge: 'Featured Solution',
    tags: ['QR Payments', 'Mobile Wallet', 'Agent Banking'],
  ),
];

class LiveWebPlatformsSection extends StatefulWidget {
  const LiveWebPlatformsSection({super.key});

  @override
  State<LiveWebPlatformsSection> createState() =>
      _LiveWebPlatformsSectionState();
}

class _LiveWebPlatformsSectionState extends State<LiveWebPlatformsSection> {
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'E-Commerce',
    'Real Estate',
    'Agency & SaaS',
    'Travel & Booking',
    'Logistics',
  ];

  List<WebPlatformData> get _filteredPlatforms {
    if (_selectedFilter == 'All') return kLiveWebPlatforms;
    return kLiveWebPlatforms
        .where(
          (p) =>
              p.filterGroup == _selectedFilter || p.category == _selectedFilter,
        )
        .toList();
  }

  int _countFor(String filter) {
    if (filter == 'All') return kLiveWebPlatforms.length;
    return kLiveWebPlatforms
        .where((p) => p.filterGroup == filter || p.category == filter)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: isMobile ? 16 : (width > 1200 ? 70 : 36),
        right: isMobile ? 16 : (width > 1200 ? 70 : 36),
        top: isMobile ? 16 : 24,
        bottom: isMobile ? 36 : 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Eyebrow ──
          Row(
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
              ),
              const SizedBox(width: 12),
              Text(
                'LIVE PRODUCTION PLATFORMS',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.2,
                ),
              ),
            ],
          ).animate().fadeIn().slideX(begin: -0.1, end: 0),

          const SizedBox(height: 18),

          // ── Header Title & Subtitle + Live Counter Pill ──
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: 24,
            runSpacing: 16,
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
                            text: 'Websites & Systems ',
                            style: GoogleFonts.spaceGrotesk(
                              color: AppColors.textPrimary,
                              fontSize: isMobile ? 32 : 44,
                              fontWeight: FontWeight.w900,
                              height: 1.15,
                              letterSpacing: -1,
                            ),
                          ),
                          TextSpan(
                            text: 'Powering Real Businesses',
                            style: GoogleFonts.spaceGrotesk(
                              color: AppColors.accent,
                              fontSize: isMobile ? 32 : 44,
                              fontWeight: FontWeight.w900,
                              height: 1.15,
                              letterSpacing: -1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Production web applications, high-converting e-commerce stores, venture studio agency platforms, and logistics systems actively handling daily customers and real transactions.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15.5,
                        height: 1.65,
                      ),
                    ),
                  ],
                ),
              ),
              _LiveStatusCounterPill(totalCount: kLiveWebPlatforms.length),
            ],
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),

          const SizedBox(height: 36),

          // ── Filter Chips ──
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                final count = _countFor(filter);
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedFilter = filter),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.accent
                              : AppColors.surfaceCard,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.accent
                                : AppColors.border,
                            width: 1.2,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.accentGlow,
                                    blurRadius: 18,
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
                                color: isSelected
                                    ? AppColors.onAccent
                                    : AppColors.textPrimary,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.black.withValues(alpha: 0.15)
                                    : AppColors.surface,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '$count',
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.onAccent
                                      : AppColors.textMuted,
                                  fontSize: 11,
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
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 36),

          // ── Responsive Grid of Web Platform Cards (3 on Laptop, 2 on Mobile) ──
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final isMobile = w < 700;
              final cols = w > 950 ? 3 : 2;
              final gap = isMobile ? 12.0 : 24.0;
              final items = _filteredPlatforms;

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
                            child: _WebPlatformCard(data: chunk[j])
                                .animate()
                                .fadeIn(delay: ((i + j) * 70).ms)
                                .slideY(begin: 0.1, end: 0),
                          ),
                          if (j < chunk.length - 1) SizedBox(width: gap),
                        ],
                        // Empty spacer slots for incomplete rows
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
// Live Status Counter Pill
// ──────────────────────────────────────────────────────────
class _LiveStatusCounterPill extends StatelessWidget {
  const _LiveStatusCounterPill({required this.totalCount});
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PulsingLiveDot(),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$totalCount Live Web Deployments',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '100% Active Production',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PulsingLiveDot extends StatefulWidget {
  @override
  State<_PulsingLiveDot> createState() => _PulsingLiveDotState();
}

class _PulsingLiveDotState extends State<_PulsingLiveDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _scale = Tween<double>(
      begin: 0.8,
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
    return Stack(
      alignment: Alignment.center,
      children: [
        ScaleTransition(
          scale: _scale,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent.withValues(alpha: 0.25),
            ),
          ),
        ),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accent,
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────
// Modern Techven Portfolio Card (Matching Image 2)
// ──────────────────────────────────────────────────────────
class _WebPlatformCard extends StatefulWidget {
  const _WebPlatformCard({required this.data});
  final WebPlatformData data;

  @override
  State<_WebPlatformCard> createState() => _WebPlatformCardState();
}

class _WebPlatformCardState extends State<_WebPlatformCard> {
  bool _hovered = false;

  Future<void> _openSite() async {
    final uri = Uri.parse(widget.data.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 700;
    final dark = ThemeController.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _hovered ? -8.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: dark ? AppColors.surfaceCard : Colors.white,
          borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
          border: Border.all(
            color: _hovered
                ? const Color(0xFFF4795B).withOpacity(0.55)
                : AppColors.border,
            width: _hovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF4795B)
                  .withOpacity(_hovered ? 0.20 : 0.0),
              blurRadius: _hovered ? 32 : 0,
              offset: Offset(0, _hovered ? 14 : 0),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(dark ? 0.35 : 0.04),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 11 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Top Image Container (Mockup Preview) ──
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _openSite,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                    child: AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AnimatedScale(
                            scale: _hovered ? 1.05 : 1.0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutCubic,
                            child: Image.asset(
                              d.screenshot,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: dark
                                      ? const Color(0xFF1E2230)
                                      : const Color(0xFFF1F3F5),
                                  child: Center(
                                    child: Icon(
                                      Icons.image_outlined,
                                      size: 40,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // Floating Pill Badge at bottom-left of preview: • Featured SaaS / • Live Client
                          Positioned(
                            left: isMobile ? 8 : 12,
                            bottom: isMobile ? 8 : 12,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 8 : 11,
                                vertical: isMobile ? 3.5 : 5.5,
                              ),
                              decoration: BoxDecoration(
                                color: dark
                                    ? Colors.black.withOpacity(0.75)
                                    : Colors.white.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: dark
                                      ? Colors.white.withOpacity(0.12)
                                      : Colors.black.withOpacity(0.08),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.12),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: isMobile ? 5 : 6.5,
                                    height: isMobile ? 5 : 6.5,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF4795B),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: isMobile ? 5 : 7),
                                  Text(
                                    d.badge,
                                    style: GoogleFonts.spaceGrotesk(
                                      color: dark
                                          ? Colors.white
                                          : const Color(0xFF1E293B),
                                      fontSize: isMobile ? 10 : 11.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: isMobile ? 12 : 18),

              // ── Category Line (Coral) ──
              Text(
                d.categoryLine,
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFFF4795B),
                  fontSize: isMobile ? 10.5 : 12.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: isMobile ? 4 : 6),

              // ── Title ──
              Text(
                d.title,
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textPrimary,
                  fontSize: isMobile ? 15 : 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: isMobile ? 6 : 8),

              // ── Description ──
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: isMobile ? 32 : 38),
                child: Text(
                  d.description,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: isMobile ? 11.5 : 13,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: isMobile ? 10 : 16),

              // ── Tag Pills ──
              Wrap(
                spacing: isMobile ? 5 : 7,
                runSpacing: isMobile ? 5 : 7,
                children: d.tags.take(isMobile ? 2 : 4).map((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 7 : 10,
                      vertical: isMobile ? 3.5 : 4.5,
                    ),
                    decoration: BoxDecoration(
                      color: dark
                          ? Colors.white.withOpacity(0.06)
                          : const Color(0xFFF4F4F6),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.border.withOpacity(0.65),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      tag,
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: isMobile ? 10 : 11.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: isMobile ? 14 : 20),

              // ── Visit Live Site Button ──
              _VisitLiveSiteBtn(url: d.url, isMobile: isMobile),
            ],
          ),
        ),
      ),
    );
  }
}

class _VisitLiveSiteBtn extends StatefulWidget {
  const _VisitLiveSiteBtn({required this.url, this.isMobile = false});
  final String url;
  final bool isMobile;

  @override
  State<_VisitLiveSiteBtn> createState() => _VisitLiveSiteBtnState();
}

class _VisitLiveSiteBtnState extends State<_VisitLiveSiteBtn> {
  bool _btnHovered = false;

  @override
  Widget build(BuildContext context) {
    final dark = ThemeController.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _btnHovered = true),
      onExit: (_) => setState(() => _btnHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: widget.isMobile ? 8 : 11),
          decoration: BoxDecoration(
            color: _btnHovered
                ? (dark
                    ? const Color(0xFFF4795B).withOpacity(0.18)
                    : const Color(0xFFFFF0EC))
                : (dark
                    ? Colors.white.withOpacity(0.04)
                    : Colors.white),
            borderRadius: BorderRadius.circular(widget.isMobile ? 10 : 12),
            border: Border.all(
              color: _btnHovered
                  ? const Color(0xFFF4795B).withOpacity(0.8)
                  : AppColors.border,
              width: 1.2,
            ),
            boxShadow: _btnHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFFF4795B).withOpacity(0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Visit live site',
                style: GoogleFonts.spaceGrotesk(
                  color: _btnHovered
                      ? const Color(0xFFF4795B)
                      : AppColors.textPrimary,
                  fontSize: widget.isMobile ? 12 : 13.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.arrow_outward_rounded,
                size: widget.isMobile ? 13 : 15,
                color: _btnHovered
                    ? const Color(0xFFF4795B)
                    : AppColors.textPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
