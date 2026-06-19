import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/home/presentation/home_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: DeveloperToolkitApp(),
    ),
  );
}

class DeveloperToolkitApp extends StatelessWidget {
  const DeveloperToolkitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Developer Toolkit',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}