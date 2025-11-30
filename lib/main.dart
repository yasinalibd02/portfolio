import 'package:flutter/material.dart';
import 'package:portfolio/router.dart';
import 'package:portfolio/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Yasin Portfolio',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Default to system, can be toggled later
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
