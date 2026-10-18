import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/web.dart' as web;

// ──────────────────────────────────────────────────────────
// Theme controller – persists the choice in localStorage
// ──────────────────────────────────────────────────────────
class ThemeController {
  static const _storageKey = 'theme_mode';

  static final ValueNotifier<ThemeMode> mode = ValueNotifier(_initialMode());

  static bool get isDark => mode.value == ThemeMode.dark;

  static ThemeMode _initialMode() {
    try {
      final saved = web.window.localStorage.getItem(_storageKey);
      if (saved == 'light') return ThemeMode.light;
      if (saved == 'dark') return ThemeMode.dark;
      // Default to light mode (matches user preference and Techven default)
      return ThemeMode.light;
    } catch (_) {
      return ThemeMode.light;
    }
  }

  static void toggle() {
    mode.value = isDark ? ThemeMode.light : ThemeMode.dark;
    try {
      web.window.localStorage.setItem(_storageKey, isDark ? 'dark' : 'light');
    } catch (_) {}
  }
}

// ──────────────────────────────────────────────────────────
// Techven Typography Utility
// ──────────────────────────────────────────────────────────
class AppFonts {
  static TextStyle display({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle body({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
}

// ──────────────────────────────────────────────────────────
// Palette Definition (Exact Techven Design System)
// ──────────────────────────────────────────────────────────
class _Palette {
  const _Palette({
    required this.background,
    required this.surface,
    required this.surfaceCard,
    required this.surfaceHover,
    required this.border,
    required this.accent,
    required this.accentDark,
    required this.accentDeep,
    required this.accentGlow,
    required this.secondaryAccent,
    required this.onAccent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.heroGradientEnd,
    required this.shadow,
    required this.gridLine,
  });

  final Color background,
      surface,
      surfaceCard,
      surfaceHover,
      border,
      accent,
      accentDark,
      accentDeep,
      accentGlow,
      secondaryAccent,
      onAccent,
      textPrimary,
      textSecondary,
      textMuted,
      heroGradientEnd,
      shadow,
      gridLine;
}

// Techven Dark Theme: Signature #0A0A0F ink black, coral gradient (#F4795B -> #F25C3B)
const _dark = _Palette(
  background: Color(0xFF0A0A0F),
  surface: Color(0xFF101018),
  surfaceCard: Color(0xFF13131D),
  surfaceHover: Color(0xFF1B1B2A),
  border: Color(0x1AFFFFFF), // rgba(255, 255, 255, 0.08)
  accent: Color(0xFFF4795B), // Techven Brand Sunset Coral
  accentDark: Color(0xFFF25C3B), // Techven Brand Flame Orange
  accentDeep: Color(0xFFD94520),
  accentGlow: Color(0x59F4795B), // rgba(244, 121, 91, 0.35)
  secondaryAccent: Color(0xFFFF9E7D), // Techven Peach Highlight
  onAccent: Color(0xFFFFFFFF),
  textPrimary: Color(0xFFFFFFFF),
  textSecondary: Color(0xFF94A3B8), // slate-400
  textMuted: Color(0xFF64748B), // slate-500
  heroGradientEnd: Color(0xFFF25C3B),
  shadow: Color(0x66000000),
  gridLine: Color(0x0AFFFFFF), // rgba(255, 255, 255, 0.04)
);

// Techven Light Theme: Signature #F7F7F9 clean slate off-white, high-contrast brand coral
const _light = _Palette(
  background: Color(0xFFF7F7F9),
  surface: Color(0xFFFFFFFF),
  surfaceCard: Color(0xFFFFFFFF),
  surfaceHover: Color(0xFFFFF6F3),
  border: Color(0x140A0A0F), // rgba(10, 10, 15, 0.08)
  accent: Color(0xFFF25C3B), // High-contrast Techven brand coral on white
  accentDark: Color(0xFFE04826),
  accentDeep: Color(0xFFC73818),
  accentGlow: Color(0x38F25C3B),
  secondaryAccent: Color(0xFFF4795B),
  onAccent: Color(0xFFFFFFFF),
  textPrimary: Color(0xFF0A0A0F), // Techven text ink black
  textSecondary: Color(0xFF55617A), // Techven slate text
  textMuted: Color(0xFF8B95A5),
  heroGradientEnd: Color(0xFFF4795B),
  shadow: Color(0x0D0A0A0F),
  gridLine: Color(0x0A0A0A0F), // rgba(10, 10, 15, 0.04)
);

/// Colors resolve against the active [ThemeController.mode], so every
/// widget picks up the new palette when the app tree rebuilds on toggle.
class AppColors {
  static _Palette get _p => ThemeController.isDark ? _dark : _light;

  static Color get background => _p.background;
  static Color get surface => _p.surface;
  static Color get surfaceCard => _p.surfaceCard;
  static Color get surfaceHover => _p.surfaceHover;
  static Color get border => _p.border;

  static Color get accent => _p.accent;
  static Color get accentDark => _p.accentDark;
  static Color get accentDeep => _p.accentDeep;
  static Color get accentGlow => _p.accentGlow;
  static Color get secondaryAccent => _p.secondaryAccent;
  static Color get onAccent => _p.onAccent;

  static Color get textPrimary => _p.textPrimary;
  static Color get textSecondary => _p.textSecondary;
  static Color get textMuted => _p.textMuted;

  static Color get heroGradientEnd => _p.heroGradientEnd;
  static Color get shadow => _p.shadow;
  static Color get gridLine => _p.gridLine;

  // Techven gradient helpers
  static LinearGradient get brandGradient => LinearGradient(
        colors: [_p.accent, _p.accentDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get heroTextGradient => LinearGradient(
        colors: [_p.textPrimary, _p.heroGradientEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}

class AppTheme {
  static ThemeData get darkTheme => _build(_dark, Brightness.dark);
  static ThemeData get lightTheme => _build(_light, Brightness.light);

  static ThemeData _build(_Palette p, Brightness brightness) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: p.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: p.accent,
        brightness: brightness,
      ).copyWith(
        surface: p.surface,
        primary: p.accent,
        secondary: p.textSecondary,
        onPrimary: p.onAccent,
        onSurface: p.textPrimary,
      ),
      // Techven typography: Space Grotesk for display/headings, Inter for body
      textTheme: TextTheme(
        displayLarge: GoogleFonts.spaceGrotesk(
          color: p.textPrimary,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.5,
        ),
        displayMedium: GoogleFonts.spaceGrotesk(
          color: p.textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.0,
        ),
        displaySmall: GoogleFonts.spaceGrotesk(
          color: p.textPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        headlineLarge: GoogleFonts.spaceGrotesk(
          color: p.textPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.spaceGrotesk(
          color: p.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: GoogleFonts.spaceGrotesk(
          color: p.textSecondary,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: GoogleFonts.spaceGrotesk(
          color: p.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: GoogleFonts.spaceGrotesk(
          color: p.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.inter(color: p.textSecondary, height: 1.8),
        bodyMedium: GoogleFonts.inter(color: p.textMuted, height: 1.6),
        bodySmall: GoogleFonts.inter(color: p.textMuted),
        labelLarge: GoogleFonts.spaceGrotesk(
          color: p.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        labelMedium: GoogleFonts.inter(
          color: p.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: p.textPrimary,
      ),
      dividerTheme: DividerThemeData(color: p.border),
      cardTheme: CardThemeData(
        color: p.surfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: p.border),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: p.surfaceCard,
        contentTextStyle: TextStyle(color: p.textPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.surfaceCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: p.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: p.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: p.accent, width: 1.5),
        ),
        labelStyle: TextStyle(color: p.textMuted),
        hintStyle: TextStyle(color: p.textMuted),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: p.accent,
          foregroundColor: p.onAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          textStyle: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: p.textPrimary,
          side: BorderSide(color: p.border, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          textStyle: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
