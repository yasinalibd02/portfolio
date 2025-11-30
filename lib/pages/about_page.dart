import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = [
      'Flutter',
      'Dart',
      'Firebase',
      'Git',
      'REST APIs',
      'UI/UX Design',
      "Figma",
      'Mobile Development',
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
                'About Me',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ).animate().fadeIn().slideX(),
              const SizedBox(height: 24),
              Text(
                """
I am a Software Engineer specializing in cross-platform mobile app development using Flutter. With 3+ years of professional experience, I have developed 50+ high-quality applications across diverse industries such as fintech, e-commerce, healthcare, crypto, transportation, and car rental.

I have also handled direct communication with clients, understanding their requirements, providing technical guidance, and delivering solutions that match their business goals.

Throughout my career, I have successfully deployed 100+ apps to the Google Play Store and Apple App Store, working on everything from UI/UX and state management to API integration, performance optimization, and app deployment.

I focus on building clean, scalable, and reliable mobile applications that ensure smooth and impactful user experiences.
""",
                style: Theme.of(context).textTheme.bodyLarge,
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 48),
              Text(
                'Skills',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(delay: 400.ms).slideX(),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: skills.map((skill) {
                  return Chip(
                    label: Text(skill),
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                  ).animate().fadeIn(delay: 600.ms).scale();
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
