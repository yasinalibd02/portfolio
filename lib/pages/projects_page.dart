import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/widgets/project_card.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<dynamic> _projects = [];
  bool _isLoading = true;

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
      debugPrint('Error loading projects: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Projects',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ).animate().fadeIn().slideX(),
              const SizedBox(height: 32),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_projects.isEmpty)
                const Center(child: Text('No projects found.'))
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    int crossAxisCount = 1;
                    if (width > 900) {
                      crossAxisCount = 3;
                    } else if (width > 600) {
                      crossAxisCount = 2;
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: _projects.length,
                      itemBuilder: (context, index) {
                        final project = _projects[index];
                        return ProjectCard(
                          title: project['title'] ?? 'Untitled',
                          description: project['description'] ?? '',
                          imageUrl: project['imageUrl'] ?? '',
                          link: project['link'],
                          tags:
                              (project['tags'] as List<dynamic>?)
                                  ?.map((e) => e.toString())
                                  .toList() ??
                              [],
                        ).animate().fadeIn(delay: (100 * index).ms).scale();
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
