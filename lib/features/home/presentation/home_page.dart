import 'package:flutter/material.dart';

import '../../../core/widgets/tool_card.dart';
import '../../../core/utils/app_routes.dart';

import '../tool_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Toolkit'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tools.length,
        itemBuilder: (context, index) {
          final tool = tools[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ToolCard(
              title: tool.title,
              description: tool.description,
              onTap: () {
                AppRoutes.push(
                  context,
                  tool.page,
                );
              },
            ),
          );
        },
      ),
    );
  }
}