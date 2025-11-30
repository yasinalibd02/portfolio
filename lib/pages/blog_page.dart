import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BlogPost {
  final String title;
  final String date;
  final String summary;
  final String content;
  final String slug;

  BlogPost({
    required this.title,
    required this.date,
    required this.summary,
    required this.content,
    required this.slug,
  });
}

class BlogPostItem extends StatefulWidget {
  final BlogPost post;
  final int index;

  const BlogPostItem({super.key, required this.post, required this.index});

  @override
  State<BlogPostItem> createState() => _BlogPostItemState();
}

class _BlogPostItemState extends State<BlogPostItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.post.date,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.post.summary,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  widget.post.content,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(height: 1.6),
                ),
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(_isExpanded ? 'Read Less' : 'Read More'),
            ),
          ],
        )
        .animate()
        .fadeIn(delay: (100 * widget.index).ms)
        .slideY(begin: 0.1, end: 0);
  }
}

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = [
      BlogPost(
        title: '3 Years of Flutter: Lessons Learned',
        date: 'November 28, 2025',
        summary:
            'Reflecting on my journey building cross-platform applications, from the early days of GetX to mastering Provider and Bloc. Key takeaways on architecture and scalability.',
        content: '''
Over the past three years, I've had the privilege of working on a diverse range of Flutter projects. My journey began with efficient state management solutions like GetX, which offered a great developer experience. However, as applications grew in complexity, I explored other architectures.

I transitioned to Provider for its compile-time safety and flexibility, which significantly improved my development workflow. Later, for large-scale enterprise applications, I adopted the BLoC pattern to ensure a clear separation of concerns and testability.

One of the biggest lessons I've learned is the importance of widget composition. Breaking down complex UIs into smaller, reusable components not only makes the code more maintainable but also enhances performance by minimizing rebuilds.

Another key area is error handling. Implementing a consistent error handling strategy across the app, using tools like Dartz for functional programming concepts, has saved countless hours of debugging.

Finally, keeping up with the Flutter ecosystem is crucial. The framework evolves rapidly, and staying updated with the latest features, such as the recent rendering engine improvements (Impeller), ensures that the apps we build are top-notch.
''',
        slug: 'flutter-lessons',
      ),
      BlogPost(
        title: 'Optimizing Performance in Flutter Web',
        date: 'November 15, 2025',
        summary:
            'A deep dive into rendering performance, reducing jank, and optimizing bundle sizes for production-grade web applications. Tips for smoother animations and faster load times.',
        content: '''
Flutter Web has come a long way, but optimizing it for production still requires a keen eye for detail. One of the primary challenges is the initial load time. To mitigate this, I've found that deferred loading of libraries and splitting the main bundle can make a massive difference.

Rendering performance is another critical aspect. Using the 'const' constructor wherever possible helps Flutter's widget reconstruction mechanism. Additionally, being mindful of the 'Opacity' widget and preferring 'AnimatedOpacity' or explicit animations can prevent unnecessary repaints.

For images, using network caching and appropriate formats like WebP is essential. I also recommend using the 'flutter_svg' package carefully, as complex SVGs can be expensive to parse and render on the web.

Lastly, don't ignore the 'build' method. Keep it pure and free of expensive computations. Move complex logic to your state management layer or use 'Isolate' for heavy processing to keep the UI thread smooth.
''',
        slug: 'flutter-web-performance',
      ),
    ];

    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Blog',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ).animate().fadeIn().slideX(),
              const SizedBox(height: 32),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: posts.length,
                separatorBuilder: (context, index) => const Divider(height: 48),
                itemBuilder: (context, index) {
                  return BlogPostItem(post: posts[index], index: index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
