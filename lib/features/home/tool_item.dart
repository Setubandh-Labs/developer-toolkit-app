import 'package:flutter/material.dart';

class ToolItem {
  final String title;
  final String description;
  final Widget page;

  const ToolItem({
    required this.title,
    required this.description,
    required this.page,
  });
}