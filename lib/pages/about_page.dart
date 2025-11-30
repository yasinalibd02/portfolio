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
      'Web Development',
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
                "I am a software engineer with a strong focus on cross-platform development using Flutter. I love solving complex problems and creating intuitive user experiences. When I'm not coding, you can find me exploring new technologies or contributing to open-source projects.",
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
