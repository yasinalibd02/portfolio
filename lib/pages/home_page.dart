import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 64),
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                  'assets/images/profile.png',
                ), // Placeholder
              ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 32),
              Text(
                "Hi, I'm Yasin Ali",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 16),
              Text(
                "A Flutter Developer passionate about building beautiful and functional web and mobile applications.",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () => context.go('/projects'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('View My Projects'),
              ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  launchUrl(Uri.parse('assets/resume.pdf'));
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Download Resume'),
              ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
