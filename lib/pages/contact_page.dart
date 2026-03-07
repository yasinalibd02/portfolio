import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/theme.dart';
import 'package:url_launcher/url_launcher.dart';

const String kContactWebhookUrl = '';
const String kPhoneNumber = '+8801308985262';
const String kEmail = 'yasinalibd02@gmail.com';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  bool _sending = false;
  bool _sent = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);

    try {
      if (kContactWebhookUrl.isNotEmpty) {
        final res = await http.post(
          Uri.parse(kContactWebhookUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'content': '📩 New portfolio contact!',
            'embeds': [
              {
                'title': 'Portfolio Contact',
                'fields': [
                  {'name': 'Name', 'value': _nameCtrl.text, 'inline': true},
                  {'name': 'Email', 'value': _emailCtrl.text, 'inline': true},
                  {'name': 'Message', 'value': _messageCtrl.text},
                ],
                'color': 0x00D97E,
              },
            ],
          }),
        );
        if (res.statusCode < 200 || res.statusCode >= 300) {
          throw Exception('HTTP ${res.statusCode}');
        }
      } else {
        final uri = Uri(
          scheme: 'mailto',
          path: kEmail,
          query: _encodeParams({
            'subject': 'Portfolio Contact: ${_nameCtrl.text}',
            'body': 'From: ${_emailCtrl.text}\n\n${_messageCtrl.text}',
          }),
        );
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      }
      if (mounted) {
        setState(() => _sent = true);
        _formKey.currentState!.reset();
        _nameCtrl.clear();
        _emailCtrl.clear();
        _messageCtrl.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  String? _encodeParams(Map<String, String> p) => p.entries
      .map(
        (e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
      )
      .join('&');

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 800;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 20 : 80,
        isMobile ? 32 : 100,
        isMobile ? 20 : 80,
        60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: 'GET IN TOUCH').animate().fadeIn(),
          const SizedBox(height: 14),

          Text(
            "Let's Work\nTogether",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: isMobile ? 36 : 58,
              fontWeight: FontWeight.w900,
              height: 1.1,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 12),
          const Text(
            "Have a project in mind? Message me anywhere below — I respond fast!",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.6,
            ),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 40),

          // Quick contact buttons
          _QuickContactRow(
            isMobile: isMobile,
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),

          const SizedBox(height: 48),

          // Main area
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ContactInfoCard(),
                    const SizedBox(height: 24),
                    _FormCard(
                      formKey: _formKey,
                      nameCtrl: _nameCtrl,
                      emailCtrl: _emailCtrl,
                      messageCtrl: _messageCtrl,
                      sending: _sending,
                      sent: _sent,
                      onSubmit: _submit,
                      onReset: () => setState(() => _sent = false),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _ContactInfoCard()),
                    const SizedBox(width: 32),
                    Expanded(
                      flex: 3,
                      child: _FormCard(
                        formKey: _formKey,
                        nameCtrl: _nameCtrl,
                        emailCtrl: _emailCtrl,
                        messageCtrl: _messageCtrl,
                        sending: _sending,
                        sent: _sent,
                        onSubmit: _submit,
                        onReset: () => setState(() => _sent = false),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────
// Quick Contact Row (WhatsApp / SMS / Email)
// ─────────────────────────────────────────────────
class _QuickContactRow extends StatelessWidget {
  const _QuickContactRow({required this.isMobile});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _QuickBtn(
          label: 'WhatsApp',
          icon: FontAwesomeIcons.whatsapp,
          color: const Color(0xFF25D366),
          url: 'https://wa.me/$kPhoneNumber',
        ),
        _QuickBtn(
          label: 'Send SMS',
          icon: Icons.sms_rounded,
          color: AppColors.accent,
          url: 'sms:$kPhoneNumber',
          isMaterial: true,
        ),
        _QuickBtn(
          label: 'Email Me',
          icon: Icons.email_rounded,
          color: const Color(0xFF4285F4),
          url: 'mailto:$kEmail',
          isMaterial: true,
        ),
      ],
    );
  }
}

class _QuickBtn extends StatefulWidget {
  const _QuickBtn({
    required this.label,
    required this.icon,
    required this.color,
    required this.url,
    this.isMaterial = false,
  });
  final String label;
  final dynamic icon;
  final Color color;
  final String url;
  final bool isMaterial;

  @override
  State<_QuickBtn> createState() => _QuickBtnState();
}

class _QuickBtnState extends State<_QuickBtn> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        child: AnimatedContainer(
          duration: 200.ms,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          decoration: BoxDecoration(
            color: _h ? widget.color.withOpacity(0.15) : AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _h ? widget.color.withOpacity(0.5) : AppColors.border,
            ),
            boxShadow: _h
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.2),
                      blurRadius: 16,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.isMaterial
                  ? Icon(
                      widget.icon as IconData,
                      color: _h ? widget.color : AppColors.textSecondary,
                      size: 18,
                    )
                  : FaIcon(
                      widget.icon as IconData,
                      color: _h ? widget.color : AppColors.textSecondary,
                      size: 17,
                    ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  color: _h ? widget.color : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────
// Contact Info Card
// ─────────────────────────────────────────────────
class _ContactInfoCard extends StatelessWidget {
  final _links = const [
    _LinkData(
      FontAwesomeIcons.github,
      'GitHub',
      'github.com/yasinalibd02',
      'https://github.com/yasinalibd02',
      false,
    ),
    _LinkData(
      FontAwesomeIcons.linkedin,
      'LinkedIn',
      'in/yasinalibd02',
      'https://www.linkedin.com/in/yasinalibd02',
      false,
    ),
    _LinkData(
      FontAwesomeIcons.twitter,
      'Twitter',
      '@YasinAl99967413',
      'https://x.com/YasinAl99967413',
      false,
    ),
    _LinkData(
      FontAwesomeIcons.whatsapp,
      'WhatsApp',
      '+880 130 898 5262',
      'https://wa.me/8801308985262',
      false,
    ),
    _LinkData(
      FontAwesomeIcons.facebook,
      'Facebook',
      'facebook.com/yasinarafat02',
      'https://www.facebook.com/yasinarafat02',
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Direct Contact',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            kEmail,
            style: TextStyle(color: AppColors.accent, fontSize: 12.5),
          ),
          const SizedBox(height: 4),
          Text(
            kPhoneNumber,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 20),
          Container(height: 1, color: AppColors.border),
          const SizedBox(height: 16),
          ..._links.map((l) => _SocialLink(data: l)),
        ],
      ),
    ).animate().fadeIn(delay: 350.ms).slideX(begin: -0.08, end: 0);
  }
}

class _LinkData {
  final IconData icon;
  final String platform, handle, url;
  final bool isMaterial;
  const _LinkData(
    this.icon,
    this.platform,
    this.handle,
    this.url,
    this.isMaterial,
  );
}

class _SocialLink extends StatefulWidget {
  const _SocialLink({required this.data});
  final _LinkData data;

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.data.url);
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        child: AnimatedContainer(
          duration: 200.ms,
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: _h ? AppColors.accent.withOpacity(0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              FaIcon(
                widget.data.icon,
                size: 15,
                color: _h ? AppColors.accent : AppColors.textMuted,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.platform,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 10,
                      letterSpacing: 0.4,
                    ),
                  ),
                  Text(
                    widget.data.handle,
                    style: TextStyle(
                      color: _h ? AppColors.accent : AppColors.textSecondary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.open_in_new_rounded,
                size: 13,
                color: _h ? AppColors.accent : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────
// Form Card
// ─────────────────────────────────────────────────
class _FormCard extends StatelessWidget {
  const _FormCard({
    required this.formKey,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.messageCtrl,
    required this.sending,
    required this.sent,
    required this.onSubmit,
    required this.onReset,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl, emailCtrl, messageCtrl;
  final bool sending, sent;
  final VoidCallback onSubmit, onReset;

  @override
  Widget build(BuildContext context) {
    if (sent) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.accent.withOpacity(0.3)),
          boxShadow: [BoxShadow(color: AppColors.accentGlow, blurRadius: 30)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppColors.accent,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Message Sent! 🎉',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "I'll get back to you within 24 hours.",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 28),
            TextButton(
              onPressed: onReset,
              child: const Text(
                'Send Another Message',
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn().scale(begin: const Offset(0.88, 0.88));
    }

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Send a Message',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 19,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "I'll reply within 24 hours.",
              style: TextStyle(color: AppColors.textMuted, fontSize: 12.5),
            ),
            const SizedBox(height: 24),

            _FieldRow(
              a: _FormField(
                ctrl: nameCtrl,
                label: 'Full Name',
                hint: 'John Doe',
                icon: Icons.person_outline_rounded,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              b: _FormField(
                ctrl: emailCtrl,
                label: 'Email Address',
                hint: 'john@example.com',
                icon: Icons.email_outlined,
                keyboard: TextInputType.emailAddress,
                validator: (v) {
                  if (v!.isEmpty) return 'Required';
                  if (!v.contains('@')) return 'Invalid email';
                  return null;
                },
              ),
            ).animate().fadeIn(delay: 300.ms),

            const SizedBox(height: 14),

            _FormField(
              ctrl: messageCtrl,
              label: 'Your Message',
              hint: 'Tell me about your project...',
              icon: Icons.chat_bubble_outline_rounded,
              maxLines: 5,
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ).animate().fadeIn(delay: 400.ms),

            const SizedBox(height: 20),

            _SubmitButton(
              sending: sending,
              onTap: onSubmit,
            ).animate().fadeIn(delay: 500.ms),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.08, end: 0);
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({required this.a, required this.b});
  final Widget a, b;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    return isMobile
        ? Column(children: [a, const SizedBox(height: 14), b])
        : Row(
            children: [
              Expanded(child: a),
              const SizedBox(width: 14),
              Expanded(child: b),
            ],
          );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.ctrl,
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboard,
    this.validator,
  });

  final TextEditingController ctrl;
  final String label, hint;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrl,
      maxLines: maxLines,
      keyboardType: keyboard,
      validator: validator,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.textMuted, size: 17),
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  const _SubmitButton({required this.sending, required this.onTap});
  final bool sending;
  final VoidCallback onTap;

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: widget.sending
          ? SystemMouseCursors.wait
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.sending ? null : widget.onTap,
        child: AnimatedContainer(
          duration: 200.ms,
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            color: _h ? AppColors.accentDark : AppColors.accent,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentGlow,
                blurRadius: _h ? 28 : 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: widget.sending
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.background,
                    ),
                  )
                : const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Send Message',
                        style: TextStyle(
                          color: AppColors.background,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          letterSpacing: 0.2,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.send_rounded,
                        color: AppColors.background,
                        size: 17,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────
// Shared Section Label
// ─────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 2,
          color: AppColors.accent,
          margin: const EdgeInsets.only(right: 10),
        ),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.accent,
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
          ),
        ),
      ],
    );
  }
}
