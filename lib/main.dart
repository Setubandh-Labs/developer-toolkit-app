import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      home: const Scaffold(
        body: Center(
          child: Text('Developer Toolkit'),
        ),
      ),
    );
  }
}