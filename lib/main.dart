import 'package:flutter/material.dart';
import 'package:portfolio/router.dart';
import 'package:portfolio/theme.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    ThemeController.mode.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    ThemeController.mode.removeListener(_onThemeChanged);
    super.dispose();
  }

  // AppColors are plain getters (not inherited), so force every element –
  // including const widgets – to rebuild while keeping their state.
  void _onThemeChanged() {
    setState(() {});
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MD Yasin Ali — Full Stack Developer',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeController.mode.value,
      themeAnimationDuration: Duration.zero,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
