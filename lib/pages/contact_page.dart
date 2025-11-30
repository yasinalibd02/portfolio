import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// TODO: Replace with your actual Webhook URL (Discord, Formspree, etc.)
const String kContactWebhookUrl = '';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSending = true;
    });

    try {
      if (kContactWebhookUrl.isNotEmpty) {
        // Send to Webhook
        final response = await http.post(
          Uri.parse(kContactWebhookUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            // Discord Webhook format (adjust if using another service)
            'content': 'New Contact Form Submission!',
            'embeds': [
              {
                'title': 'Portfolio Contact',
                'fields': [
                  {
                    'name': 'Name',
                    'value': _nameController.text,
                    'inline': true,
                  },
                  {
                    'name': 'Email',
                    'value': _emailController.text,
                    'inline': true,
                  },
                  {'name': 'Message', 'value': _messageController.text},
                ],
                'color': 5814783, // Purple color
              },
            ],
            // Generic JSON format for other services
            'name': _nameController.text,
            'email': _emailController.text,
            'message': _messageController.text,
          }),
        );

        if (response.statusCode >= 200 && response.statusCode < 300) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Message sent successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            _formKey.currentState!.reset();
            _nameController.clear();
            _emailController.clear();
            _messageController.clear();
          }
        } else {
          throw Exception('Failed to send message: ${response.statusCode}');
        }
      } else {
        // Fallback to Mailto
        final Uri emailLaunchUri = Uri(
          scheme: 'mailto',
          path: 'yasin@example.com', // Replace with actual email
          query: encodeQueryParameters(<String, String>{
            'subject': 'Portfolio Contact: ${_nameController.text}',
            'body':
                'From: ${_emailController.text}\n\n${_messageController.text}',
          }),
        );

        if (await canLaunchUrl(emailLaunchUri)) {
          await launchUrl(emailLaunchUri);
        } else {
          throw Exception('Could not launch email client');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending message: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get in Touch',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ).animate().fadeIn().slideX(),
              const SizedBox(height: 16),
              Text(
                "Have a project in mind or just want to say hi? Feel free to send me a message!",
                style: Theme.of(context).textTheme.bodyLarge,
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ).animate().fadeIn(delay: 300.ms),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ).animate().fadeIn(delay: 400.ms),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                    ).animate().fadeIn(delay: 500.ms),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isSending ? null : _submitForm,
                        child: _isSending
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Send Message'),
                      ),
                    ).animate().fadeIn(delay: 600.ms),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialIcon(
                    icon: FontAwesomeIcons.github,
                    url: 'https://github.com/yasinalibd02',
                  ),
                  const SizedBox(width: 24),
                  _SocialIcon(
                    icon: FontAwesomeIcons.linkedin,
                    url: 'https://www.linkedin.com/in/yasinalibd02',
                  ),
                  const SizedBox(width: 24),
                  _SocialIcon(
                    icon: FontAwesomeIcons.twitter,
                    url: 'https://x.com/YasinAl99967413',
                  ),
                ],
              ).animate().fadeIn(delay: 800.ms).scale(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({required this.icon, required this.url});

  final IconData icon;
  final String url;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(icon, size: 32),
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
    );
  }
}
