import 'package:flutter/material.dart';

class AppRoutes {
  static Future<void> push(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }
}