import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/theme.dart';

class BlogPost {
  final String title;
  final String date;
  final String category;
  final String readTime;
  final String summary;
  final String content;

  const BlogPost({
    required this.title,
    required this.date,
    required this.category,
    required this.readTime,
    required this.summary,
    required this.content,
  });
}

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  static final _posts = [
    const BlogPost(
      title: '3 Years of Flutter: Lessons Learned',
      date: 'November 28, 2025',
      category: 'Flutter',
      readTime: '5 min read',
      summary:
          'Reflecting on my journey building cross-platform applications, from the early days of GetX to mastering Provider and BLoC. Key takeaways on architecture and scalability.',
      content:
          '''Over the past three years, I've had the privilege of working on a diverse range of Flutter projects. My journey began with GetX for state management, then I explored Provider for compile-time safety, and finally settled on BLoC for large-scale enterprise apps.

One of the biggest lessons I've learned is the importance of widget composition — breaking down complex UIs into smaller, reusable components improves both maintainability and performance by minimizing unnecessary rebuilds.

Another key area is consistent error handling using patterns like Either/Result types. This has saved countless hours of debugging across teams.''',
    ),
    const BlogPost(
      title: 'Optimizing Performance in Flutter Web',
      date: 'November 15, 2025',
      category: 'Performance',
      readTime: '7 min read',
      summary:
          'A deep dive into rendering performance, reducing jank, and optimizing bundle sizes for production-grade Flutter web applications.',
      content:
          '''Flutter Web has matured significantly, but production optimization still requires careful attention. The biggest wins come from deferred library loading, using WebP images, and being strategic about when `const` constructors are used.

Rendering performance is critical. The `Opacity` widget is costly — prefer `AnimatedOpacity` or `FadeTransition` for better performance. Always profile with Flutter DevTools before shipping.

For initial load times, consider skeleton loaders and lazy data fetching to give users instant visual feedback while heavy content loads in the background.''',
    ),
    const BlogPost(
      title: 'Clean Architecture in Flutter',
      date: 'October 30, 2025',
      category: 'Architecture',
      readTime: '8 min read',
      summary:
          'How I structure Flutter apps for scalability, testability, and long-term maintainability using SOLID principles and domain-driven design.',
      content:
          '''Clean Architecture separates your app into Presentation, Domain, and Data layers. In Flutter, this means: your UI widgets only know about BLoC/Cubit, BLoC only knows about Use Cases, and Use Cases only know about Repositories.

This makes testing trivial — each layer can be tested in isolation. It also makes onboarding new developers much easier as the folder structure is self-documenting.

The trade-off is initial boilerplate. I recommend using code generation tools like `mason` to scaffold common patterns quickly.''',
    ),
  ];

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
          // Section label
          _SectionLabel(label: 'MY THOUGHTS').animate().fadeIn(),
          const SizedBox(height: 16),

          Text(
            'Blog & Insights',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: isMobile ? 36 : 56,
              fontWeight: FontWeight.w900,
            ),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 8),
          const Text(
            'Thoughts on Flutter, architecture, and modern app development.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 48),

          // Blog posts
          ..._posts.indexed.map((entry) {
            final (i, post) = entry;
            return _BlogCard(post: post)
                .animate()
                .fadeIn(delay: (i * 120 + 300).ms)
                .slideY(begin: 0.1, end: 0);
          }),
        ],
      ),
    );
  }
}

class _BlogCard extends StatefulWidget {
  const _BlogCard({required this.post});
  final BlogPost post;

  @override
  State<_BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<_BlogCard> {
  bool _expanded = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withOpacity(0.3)
                : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meta row
            Row(
              children: [
                _CategoryPill(label: widget.post.category),
                const Spacer(),
                Text(
                  widget.post.date,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.access_time_rounded,
                  color: AppColors.textMuted,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.post.readTime,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Title
            Text(
              widget.post.title,
              style: TextStyle(
                color: _hovered ? AppColors.accent : AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 12),

            // Summary
            Text(
              widget.post.summary,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.7,
              ),
            ),

            // Expanded content
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 1,
                      color: AppColors.border,
                      margin: const EdgeInsets.only(bottom: 16),
                    ),
                    Text(
                      widget.post.content,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: _expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),

            const SizedBox(height: 20),

            // Read more button
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _expanded ? 'Collapse' : 'Read More',
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 6),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.accent,
                      size: 18,
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

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.accent,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
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
